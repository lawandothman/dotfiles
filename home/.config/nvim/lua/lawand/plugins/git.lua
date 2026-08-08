return {
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git', 'Gdiffsplit', 'Gvdiffsplit', 'Gread', 'Gwrite', 'Gedit', 'Glog', 'Gclog' },
    dependencies = { { 'tpope/vim-rhubarb', cmd = { 'GBrowse' } } },
  },
}
