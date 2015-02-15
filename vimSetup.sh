## Backup existing vimrc
mv ~/.vimrc ~/.vimrc.bak
mv $HOME/tools $HOME/tools.vim.bak

TOOLS=$HOME/tools

## Plugin-independent stuff
echo "set ignorecase" >> ~/.vimrc
echo "set hlsearch" >> ~/.vimrc
echo "set nu" >> ~/.vimrc
echo "set tabstop=2 expandtab" >> ~/.vimrc
echo "set shiftwidth=2" >> ~/.vimrc
echo "set cursorline" >> ~/.vimrc
echo "\" Functions to comment/uncomment a single line of code" >> ~/.vimrc
echo "function! Comment()" >> ~/.vimrc
echo "let ext = tolower(expand('%:e'))" >> ~/.vimrc
echo "if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'" >> ~/.vimrc
echo "silent s/^/\#/" >> ~/.vimrc
echo "elseif ext == 'js' || ext == 'scala' || ext == 'cpp' || ext == 'c' || ext == 'h' || ext == 'v'" >> ~/.vimrc
echo "silent s:^:\/\/:g" >> ~/.vimrc
echo "elseif ext == 'vim'" >> ~/.vimrc
echo "silent s:^:\\\":g" >> ~/.vimrc
echo "endif" >> ~/.vimrc
echo "endfunction" >> ~/.vimrc

echo "function! Uncomment()" >> ~/.vimrc
echo "let ext = tolower(expand('%:e'))" >> ~/.vimrc
echo "if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'" >> ~/.vimrc
echo "silent s/^\#//" >> ~/.vimrc
echo "elseif ext == 'js' || ext == 'scala' || ext == 'cpp' || ext == 'c' || ext == 'h' || ext == 'v'" >> ~/.vimrc
echo "silent s:^\/\/::g" >> ~/.vimrc
echo "elseif ext == 'vim'" >> ~/.vimrc
echo "silent s:^\\\"::g" >> ~/.vimrc
echo "endif" >> ~/.vimrc
echo "endfunction" >> ~/.vimrc

echo "map <C-a> :call Comment()<CR>" >> ~/.vimrc
echo "map <C-b> :call Uncomment()<CR>" >> ~/.vimrc


## Keybindings
echo "\"Paste toggle - do not automatically tab code that is copy-pasted" >> ~/.vimrc
echo "\"http://stackoverflow.com/questions/2861627/paste-in-insert-mode" >> ~/.vimrc
echo "set pastetoggle=<F2>" >> ~/.vimrc
echo "\"Clear search" >> ~/.vimrc
echo "nnoremap <F5> :noh<CR>" >> ~/.vimrc
echo "\"Save" >> ~/.vimrc
echo "nnoremap <C-s> :w<CR>" >> ~/.vimrc
echo "\" Smart way to move between windows" >> ~/.vimrc
echo "map <C-Down> <C-W>j" >> ~/.vimrc
echo "map <C-Up> <C-W>k" >> ~/.vimrc
echo "map <C-Left> <C-W>h" >> ~/.vimrc
echo "map <C-Right> <C-W>l" >> ~/.vimrc
echo "\"Copy-paste from clipboard" >> ~/.vimrc
echo "map <C-c> \"+y" >> ~/.vimrc
echo "map <C-v> \"*p" >> ~/.vimrc

## Ctags-specific stuff along with bindings for LMS, Delite, Forge
sudo apt-get install exuberant-ctags
echo "set tags=./.tags;" >> ~/.vimrc
echo "set tags+=./.tagsComp;" >> ~/.vimrc
echo "set tags+=./.tagsShared;" >> ~/.vimrc
echo "set tags+=./.tagsFramework;" >> ~/.vimrc
echo "set tags+=./.tagsRuntime;" >> ~/.vimrc


## Install pathogen
echo "Installing pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  wget -O ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
echo "execute pathogen#infect()" >> ~/.vimrc
echo "syntax on" >> ~/.vimrc
echo "filetype plugin indent on" >> ~/.vimrc

## Install vim-sensible
echo "Installing vim-sensible"
cd ~/.vim/bundle && \
git clone git://github.com/tpope/vim-sensible.git

## Command-T
echo "Installing Ctrl-P"
git clone https://github.com/kien/ctrlp.vim.git bundle/ctrlp.vim
echo "set runtimepath^=~/.vim/bundle/ctrlp.vim" >> ~/.vimrc
vim +Helptags ~/.vim/bundle/ctrlp.vim/doc

## Highlight white space
git clone https://github.com/bronson/vim-trailing-whitespace.git

## Ag
echo "Installing Ag, silver searcher"
sudo apt-get install silversearcher-ag
cd $TOOLS && git clone https://github.com/ggreer/the_silver_searcher ag && cd ag && ./build.sh && sudo make install
cd ~/.vim/bundle && git clone https://github.com/rking/ag.vim ag && vim +Helptags
echo "\" The Silver Searcher" >> ~/.vimrc
echo "if executable('ag')" >> ~/.vimrc
echo "	\" \" Use ag over grep" >> ~/.vimrc
echo "	set grepprg=ag\ --nogroup\ --nocolor" >> ~/.vimrc
echo "	\" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore" >> ~/.vimrc
echo "	let g:ctrlp_user_command = 'ag %s -l --nocolor -g \"\"'" >> ~/.vimrc
echo "	\" ag is fast enough that CtrlP doesn't need to cache" >> ~/.vimrc
echo "	let g:ctrlp_use_caching = 0" >> ~/.vimrc
echo "	endif" >> ~/.vimrc
echo "	\" \" bind K to grep word under cursor" >> ~/.vimrc
echo "	nnoremap K :grep! \"\b<C-R><C-W>\b\"<CR>:cw<CR>" >> ~/.vimrc
echo "	\" bind \ (backward slash) to grep shortcut" >> ~/.vimrc
echo "	command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!" >> ~/.vimrc
echo "	nnoremap \ :Ag<SPACE>" >> ~/.vimrc
echo "	\" Use <leader><Enter> from quick fix window to open the highlighted file in a" >> ~/.vimrc
echo "	\" new vertical split" >> ~/.vimrc
echo "	\" http://stackoverflow.com/questions/16743112/open-item-from-quickfix-window-in-vertical-split" >> ~/.vimrc
echo "	autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L" >> ~/.vimrc

## Rainbow parenthesis
echo "Installing rainbow parentheses"
cd ~/.vim/bundle && git clone https://github.com/kien/rainbow_parentheses.vim.git && vim +Helptags
echo "au VimEnter * RainbowParenthesesToggle" >> ~/.vimrc
echo "au Syntax * RainbowParenthesesLoadRound" >> ~/.vimrc
echo "au Syntax * RainbowParenthesesLoadSquare" >> ~/.vimrc
echo "au VimEnter * RainbowParenthesesLoadBraces" >> ~/.vimrc

# supertab
echo "Installing supertab"
cd ~/.vim/bundle && git clone https://github.com/ervandew/supertab.git && vim +Helptags

# tagbar
echo "Installing tagbar"
cd ~/.vim/bundle && git clone https://github.com/majutsushi/tagbar.git && vim +Helptags
# Add scala support
echo "let g:tagbar_type_scala = {" >> ~/.vimrc
echo "    \ 'ctagstype' : 'Scala'," >> ~/.vimrc
echo "    \ 'kinds'     : [" >> ~/.vimrc
echo "    \ 'p:packages:1'," >> ~/.vimrc
echo "    \ 'V:values'," >> ~/.vimrc
echo "    \ 'v:variables'," >> ~/.vimrc
echo "    \ 'T:types'," >> ~/.vimrc
echo "    \ 't:traits'," >> ~/.vimrc
echo "    \ 'o:objects'," >> ~/.vimrc
echo "    \ 'a:aclasses'," >> ~/.vimrc
echo "    \ 'c:classes'," >> ~/.vimrc
echo "    \ 'r:cclasses'," >> ~/.vimrc
echo "    \ 'm:methods'" >> ~/.vimrc
echo "    \ ]" >> ~/.vimrc
echo "\ }" >> ~/.vimrc
# Keybinding
echo "nmap <F8> :TagbarToggle<CR>" >> ~/.vimrc


# vim-solarized
# echo "Installing vim-solarized"
# cd ~/.vim/bundle && git clone https://github.com/altercation/vim-colors-solarized.git && vim +Helptags
# echo "set background=dark" >> ~/.vimrc
# echo "colorscheme solarized" >> ~/.vimrc 
## Install https://github.com/Anthony25/gnome-terminal-colors-solarized to get the colours right
# echo "Install https://github.com/Anthony25/gnome-terminal-colors-solarized to get the colours right"
# Vim colorschemes
cd ~/.vim/bundle && git clone https://github.com/flazz/vim-colorschemes.git
echo "colorscheme solarized" >> ~/.vimrc
echo "set background=dark" >> ~/.vimrc
echo "colorscheme railscasts" >> ~/.vimrc

# ZoomWin
echo "Installing ZoomWin"
cd ~/.vim/bundle && git clone https://github.com/vim-scripts/ZoomWin.git && vim +Helptags
echo "\" Zoom window" >> ~/.vimrc
echo "nmap <leader>o <c-w>o" >> ~/.vimrc

# Fugitive
echo "Installing vim-fugitive"
cd ~/.vim/bundle && git clone https://github.com/tpope/vim-fugitive.git
vim -u NONE -c "helptags vim-fugitive/doc" -c q

# Gitgutter
echo "Installing vim-gitgutter"
cd ~/.vim/bundle && git clone https://github.com/airblade/vim-gitgutter.git
echo "nmap ]h <Plug>GitGutterNextHunk" >> ~/.vimrc
echo "nmap [h <Plug>GitGutterPrevHunk" >> ~/.vimrc

# Airline
echo "Installing airline"
cd ~/.vim/bundle && git clone https://github.com/bling/vim-airline.git && vim +Helptags
echo "\"airline" >> ~/.vimrc
echo "let g:airline#extensions#tabline#enabled = 1" >> ~/.vimrc
echo "let g:airline_left_sep = '▶'" >> ~/.vimrc
echo "let g:airline_right_sep = '«'" >> ~/.vimrc

# vim-bufferline
echo "Installing bufferline"
cd ~/.vim/bundle && git clone https://github.com/bling/vim-bufferline.git && vim +Helptags

# vim-scala
echo "Installing vim-scala"
cd ~/.vim/bundle && git clone https://github.com/derekwyatt/vim-scala.git && vim +Helptags

echo "Verilog support: http://blog.edmondcote.com/2011/05/vim-setup-for-systemverilog.html"
echo "Installing vim-matchit"
cd ~/.vim/bundle && git clone https://github.com/eshock/vim-matchit.git && vim +Helptags

cat >> ~/.vimrc << DELIM
if exists('loaded_matchit')
let b:match_ignorecase=0
let b:match_words=
  \ '\<begin\>:\<end\>,' .
  \ '\<if\>:\<else\>,' .
  \ '\<module\>:\<endmodule\>,' .
  \ '\<class\>:\<endclass\>,' .
  \ '\<program\>:\<endprogram\>,' .
  \ '\<clocking\>:\<endclocking\>,' .
  \ '\<property\>:\<endproperty\>,' .
  \ '\<sequence\>:\<endsequence\>,' .
  \ '\<package\>:\<endpackage\>,' .
  \ '\<covergroup\>:\<endgroup\>,' .
  \ '\<primitive\>:\<endprimitive\>,' .
  \ '\<specify\>:\<endspecify\>,' .
  \ '\<generate\>:\<endgenerate\>,' .
  \ '\<interface\>:\<endinterface\>,' .
  \ '\<function\>:\<endfunction\>,' .
  \ '\<task\>:\<endtask\>,' .
  \ '\<case\>\|\<casex\>\|\<casez\>:\<endcase\>,' .
  \ '\<fork\>:\<join\>\|\<join_any\>\|\<join_none\>,' .
endif
DELIM


