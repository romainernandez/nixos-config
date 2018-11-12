with import <nixpkgs> {};

vim_configurable.customize {
    # Specifies the vim binary name.
    # E.g. set this to "my-vim" and you need to type "my-vim" to open this vim
    # This allows to have multiple vim packages installed (e.g. with a different set of plugins)
    name = "vim";
    vimrcConfig.customRC = ''
        syntax on
        colorscheme desert
        set incsearch
        set hlsearch
        set backspace=indent,eol,start
        set nocompatible
        filetype indent plugin on
        set hidden
        set wildmenu
        set showcmd
        set nostartofline
        set ruler
        set laststatus=2
        set number
        set shiftwidth=4
        set softtabstop=4
        set expandtab
    '';
}
