// Based on https://gist.github.com/chardskarth/95874c54e29da6b5a36ab7b50ae2d088
float ease(float x) {
    return pow(1.0 - x, 10.0);
}

float sdBox(in vec2 p, in vec2 xy, in vec2 b)
{
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

float getSdfRectangle(in vec2 p, in vec2 xy, in vec2 b)
{
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}
// Based on Inigo Quilez's 2D distance functions article: https://iquilezles.org/articles/distfunctions2d/
// Potencially optimized by eliminating conditionals and loops to enhance performance and reduce branching
float seg(in vec2 p, in vec2 a, in vec2 b, inout float s, float d) {
    vec2 e = b - a;
    vec2 w = p - a;
    vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    float segd = dot(p - proj, p - proj);
    d = min(d, segd);

    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float allCond = c0 * c1 * c2;
    float noneCond = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
    float flip = mix(1.0, -1.0, step(0.5, allCond + noneCond));
    s *= flip;
    return d;
}

float getSdfParallelogram(in vec2 p, in vec2 v0, in vec2 v1, in vec2 v2, in vec2 v3) {
    float s = 1.0;
    float d = dot(p - v0, p - v0);

    d = seg(p, v0, v3, s, d);
    d = seg(p, v1, v0, s, d);
    d = seg(p, v2, v1, s, d);
    d = seg(p, v3, v2, s, d);

    return s * sqrt(d);
}

vec2 normalize(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

float blend(float t)
{
    float sqr = t * t;
    return sqr / (2.0 * (sqr - t) + 1.0);
}

float antialising(float distance) {
    return 1. - smoothstep(0., normalize(vec2(2., 2.), 0.).x, distance);
}

float determineStartVertexFactor(vec2 a, vec2 b) {
    float condition1 = step(b.x, a.x) * step(a.y, b.y);
    float condition2 = step(a.x, b.x) * step(b.y, a.y);
    return 1.0 - max(condition1, condition2);
}
vec2 getRectangleCenter(vec4 rectangle) {
    return vec2(rectangle.x + (rectangle.z / 2.), rectangle.y - (rectangle.w / 2.));
}

// Core magenta from cursor-color #B62EB2, toned down
const vec3 MAGENTA_CORE = vec3(0.5, 0.13, 0.49);
// Warm center, subtle not blown out
const vec3 MAGENTA_HOT = vec3(0.65, 0.25, 0.6);
// Deep purple edge for depth
const vec3 MAGENTA_DEEP = vec3(0.3, 0.03, 0.35);
// Muted cyan accent for outer glow
const vec3 CYAN_ACCENT = vec3(0.2, 0.4, 0.6);

const float DURATION = .6;
const float DRAW_THRESHOLD = 1.5;
const bool HIDE_TRAILS_ON_THE_SAME_LINE = false;

// Soft glow falloff
float glow(float d, float radius, float intensity) {
    return intensity / (1.0 + pow(abs(d) / radius, 2.0));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif

    vec2 vu = normalize(fragCoord, 1.);
    vec2 offsetFactor = vec2(-.5, 0.5);

    vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.), normalize(iCurrentCursor.zw, 0.));
    vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.), normalize(iPreviousCursor.zw, 0.));

    float vertexFactor = determineStartVertexFactor(currentCursor.xy, previousCursor.xy);
    float invertedVertexFactor = 1.0 - vertexFactor;

    vec2 v0 = vec2(currentCursor.x + currentCursor.z * vertexFactor, currentCursor.y - currentCursor.w);
    vec2 v1 = vec2(currentCursor.x + currentCursor.z * invertedVertexFactor, currentCursor.y);
    vec2 v2 = vec2(previousCursor.x + currentCursor.z * invertedVertexFactor, previousCursor.y);
    vec2 v3 = vec2(previousCursor.x + currentCursor.z * vertexFactor, previousCursor.y - previousCursor.w);

    vec4 newColor = vec4(fragColor);

    float progress = blend(clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1));
    float easedProgress = ease(progress);

    vec2 centerCC = getRectangleCenter(currentCursor);
    vec2 centerCP = getRectangleCenter(previousCursor);
    float cursorSize = max(currentCursor.z, currentCursor.w);
    float trailThreshold = DRAW_THRESHOLD * cursorSize;
    float lineLength = distance(centerCC, centerCP);

    bool isFarEnough = lineLength > trailThreshold;
    bool isOnSeparateLine = HIDE_TRAILS_ON_THE_SAME_LINE ? currentCursor.y != previousCursor.y : true;
    if (isFarEnough && isOnSeparateLine) {
        float distanceToEnd = distance(vu.xy, centerCC);
        float alphaModifier = clamp(distanceToEnd / (lineLength * easedProgress), 0.0, 1.0);

        float sdfCursor = getSdfRectangle(vu, currentCursor.xy - (currentCursor.zw * offsetFactor), currentCursor.zw * 0.5);
        float sdfTrail = getSdfParallelogram(vu, v0, v1, v2, v3);

        // How far along the trail (0 = at cursor, 1 = at old position)
        float trailPosition = clamp(distanceToEnd / lineLength, 0.0, 1.0);

        // Color gradient: hot white-pink near cursor, core magenta mid, deep purple at tail
        vec3 trailGradient = mix(MAGENTA_HOT, MAGENTA_CORE, smoothstep(0.0, 0.4, trailPosition));
        trailGradient = mix(trailGradient, MAGENTA_DEEP, smoothstep(0.4, 1.0, trailPosition));

        // Inner trail (sharp core)
        float innerTrail = antialising(sdfTrail);

        // Outer glow layers - subtle bloom
        float outerGlow1 = glow(sdfTrail, 0.012, 0.2);
        float outerGlow2 = glow(sdfTrail, 0.035, 0.07);

        // Cyan-tinted outer halo for depth
        vec3 outerColor = mix(MAGENTA_CORE, CYAN_ACCENT, 0.35);

        // Composite: outer halo first, then inner glow, then sharp core
        vec3 glowComposite = outerColor * outerGlow2;
        glowComposite += trailGradient * outerGlow1;
        glowComposite += trailGradient * innerTrail;

        // Fade everything by trail progress
        float trailAlpha = (1.0 - alphaModifier);
        newColor.rgb += glowComposite * trailAlpha;

        // Keep the cursor area clean
        fragColor = mix(vec4(newColor.rgb, 1.0), fragColor, step(sdfCursor, 0));
    }
}
