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

