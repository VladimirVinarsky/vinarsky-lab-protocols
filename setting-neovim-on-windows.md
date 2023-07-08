# setting neovim on windows

## The config file&#x20;

The config file is located in `AppData/local` and is accessed by going to the file explorer and typing `%AppData%`. From there navigate to the folder called nvim. In case the folder does not exit, create it and put a file insite called `init.vim`.

This file contains the settings you would put into the `.vimrc` file on linux system&#x20;

## Font size

`set guifont=Consolas:h12` (for linux omit the h)

## Number lines

`set number`

## Folding

\[link to tutorial with shortcuts]\([https://bitcrowd.dev/folding-sections-of-markdown-in-vim](https://bitcrowd.dev/folding-sections-of-markdown-in-vim))

`let g:markdown_folding = 1`

## Copy pasting shift insert



```vim
inoremap <silent>  <S-Insert>  <C-R>+
```

## More hacks <a href="#gui-settings" id="gui-settings"></a>

\[link to nvim on windows blog]\([https://jdhao.github.io/2019/01/17/nvim\_qt\_settings\_on\_windows/](https://jdhao.github.io/2019/01/17/nvim\_qt\_settings\_on\_windows/))

\
