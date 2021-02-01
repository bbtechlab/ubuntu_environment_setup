" Rod's .vimrc/.gvimrc file (Rod Moffitt rod@rod.info)
" $Id: vimrc,v 1.69 2011-07-11 23:34:35 rmoffitt Exp $

" Copyright (C) Rod Moffitt + others
" 
" This program is free software; you can redistribute it and/or
" modify it under the terms of the GNU General Public License
" as published by the Free Software Foundation; either version 2
" of the License, or (at your option) any later version.
" 
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
" 
" You should have received a copy of the GNU General Public License
" along with this program; if not, write to the Free Software
" Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

set cursorline
"set cursorcolumn
set nocompatible " use Vim defaults (much better!)
set ts=4 "number of spaces a tab is converted to
set sw=4 "number of spaces to use for each indent
set expandtab " expand all tabs
set nu " enable line numbering
"set mouse=hv " only allow mouse interactivity during :help
set mouse=a
set hidden " allow buffers to remain modified without writing
set bs=2 " allow backspacing over everything in insert mode
set ai " always set autoindenting on
set viminfo='100,<100,s100 " read/write a .viminfo file: 100 files worth of marks, max of 100 lines per register, 100kB max register size
"set tw=78 " uncomment to wrap text
set tw=80 " disable wrapping of text
"set backup " uncomment to keep a backup file
"set ch=2 " uncomment to make command line two lines high
"set noguipty " uncomment to make external commands work through a pipe instead of a pty
set vb t_vb= " disable visual/audible bells
set history=1000 " 1000 entry history table
set undolevels=10000 " 10000 undo levels (WARNING: this can take a lot of memory!)
set noequalalways " don't auto-resize when a window is closed
set guioptions-=T " disable the toolbar
set guioptions-=r " disable the right hand scrollbar
set guioptions-=R " disable the right hand scrollbar for vertically split window
set guioptions-=l " disable the left hand scrollbar
set guioptions-=L " disable the left hand scrollbar for vertically split window
set guioptions-=b " disable the bottom/horizontal scrollbar
set guioptions-=m " disable the menu
set mouse=a
" remap shift-insert to middle mouse button for pasting text
nnoremap <S-Insert> <MiddleMouse>
" make the single quote act like the left tick (for jumping to marks)
nnoremap ' `
" alias zz as z. since ZZ (save and quit) is too easy to accidentally hit
nnoremap ZZ z.
" restore Q as the line formatter (also, make it a single keystroke by adding <CR>)
nnoremap Q gq<CR>
" alias E, Q and W to lower case equivalents for convenience
cabbrev E e
cabbrev Q q
cabbrev W w

" font selection
set guifont=Envy\ Code\ R\ 11

" make :Man command avaliable
source $VIMRUNTIME/ftplugin/man.vim
" Default MANPAGER vimmanpager doesn't play well
" with the :Man command and we don't want to see raw colour codes
" so we use sed to strip them.
let $MANPAGER = "sed -e 's:\\x1B\\[[[:digit:]]\\+m::g'"

" enable C style indenting for C/C++, auto-wrap comments at 80 characters
augroup c
   au!
   autocmd BufRead *.c,*.cpp,*.h set formatoptions=rocql cindent textwidth=80 comments=sr:/*,mb:*,el:*/,://
augroup END

" enable C style indenting for PHP, auto-wrap comments at 80 characters
augroup php
   au!
   au BufRead *.php set formatoptions=rocql cindent textwidth=80 comments=sr:/*,mb:*,el:*/,://,:#
augroup END

" add support for second life LSL scripts, also enable C style indenting,
" auto-wrap comments at 80 characters
augroup lsl
   au!
   au BufNewFile,BufRead *.lsl setf lsl
   au BufRead *.lsl set formatoptions=rocql cindent textwidth=80 comments=://
augroup END

if has("cscope")
   set csto=0 " search with cscope first, then with ctags
   set cst " search both ctags and cscope
   set nocsverb " disable db error on load
   " add any database in current directory
   if filereadable("cscope.out")
       cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
       cs add $CSCOPE_DB
   endif
   set csverb " restore db load error display
   " CTRL + backslash to find refs to the function
   nnoremap <silent> <C-\> <ESC>:cs find 3 <C-R>=expand("<cword>")<CR><CR>
   " CTRL + underscore then a single character invokes a cs feature
   " s: Find this C symbol
   " g: Find this definition
   " d: Find functions called by this function
   " c: Find functions calling this function
   " t: Find this text string
   " e: Find this egrep pattern
   " f: Find this file
   " i: Find files #including this file
   noremap <silent> <C-_>s <ESC>:cs find s <C-R>=expand("<cword>")<CR><CR>
   noremap <silent> <C-_>g <ESC>:cs find g <C-R>=expand("<cword>")<CR><CR>
   noremap <silent> <C-_>c <ESC>:cs find c <C-R>=expand("<cword>")<CR><CR>
   noremap <silent> <C-_>t <ESC>:cs find t <C-R>=expand("<cword>")<CR><CR>
   noremap <silent> <C-_>e <ESC>:cs find e <C-R>=expand("<cword>")<CR><CR>
   noremap <silent> <C-_>f <ESC>:cs find f <C-R>=expand("<cfile>")<CR><CR>
   noremap <silent> <C-_>i <ESC>:cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
   noremap <silent> <C-_>d <ESC>:cs find d <C-R>=expand("<cword>")<CR><CR>
   " CTRL + spacebar then a single character does the same yet
   " in a new horizontal window
   noremap <silent> <C-Space>s <ESC>:scs find s <C-R>=expand("<cword>")<CR><CR>
   noremap <silent> <C-Space>g <ESC>:scs find g <C-R>=expand("<cword>")<CR><CR>
   noremap <silent> <C-Space>c <ESC>:scs find c <C-R>=expand("<cword>")<CR><CR>
   noremap <silent> <C-Space>t <ESC>:scs find t <C-R>=expand("<cword>")<CR><CR>
   noremap <silent> <C-Space>e <ESC>:scs find e <C-R>=expand("<cword>")<CR><CR>
   noremap <silent> <C-Space>f <ESC>:scs find f <C-R>=expand("<cfile>")<CR><CR>
   noremap <silent> <C-Space>i <ESC>:scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
   noremap <silent> <C-Space>d <ESC>:scs find d <C-R>=expand("<cword>")<CR><CR>
endif

" version 5+ commands
if version >= 500
   " disable highlighting strings inside C comments
   let c_comment_strings=0

   " reset and enable syntax highlighting
   hi clear Normal
   set bg&
   hi clear
   syntax reset
   syntax on

   " switch off search pattern highlighting
   se nohlsearch

   " hide the mouse pointer while typing
   set mousehide

   " set some nice colors
   " set background=dark
   "hi Normal guifg=white guibg=#00006C
   "hi Normal ctermfg=white
   "hi LineNr guifg=darkgrey
   "hi LineNr ctermfg=darkgrey
   "hi title guifg=darkgrey
   "hi title ctermfg=darkgrey
   hi VertSplit gui=NONE guifg=cyan guibg=blue
   "hi VertSplit gui=NONE ctermfg=blue ctermbg=cyan
   "hi StatusLineNC gui=NONE guifg=cyan guibg=blue
   "hi StatusLineNC gui=NONE ctermfg=blue ctermbg=cyan
   "hi StatusLine gui=bold guifg=blue guibg=cyan
   "hi StatusLine gui=bold ctermfg=cyan ctermbg=white
endif

" version 6+ commands
if version >= 600
   " disable folding
   set nofoldenable

   " enable file type detection with plugin and indent loading
   filetype plugin indent on

   " bind in F12 to save the current session
   set sessionoptions=buffers,curdir,resize,tabpages,winpos,winsize
   function! SessionSave()
      let session_directory=$HOME . "/.vim/sessions"
      if !isdirectory(session_directory)
         call mkdir(session_directory,"p","0700")
      endif
      let session_filename=session_directory . "/" . strftime("%Y%m%d_%H%M%S.vim")
      exe 'mksession ' . session_filename
      echomsg "session saved to " . session_filename
   endfunction
   nnoremap <F12> <ESC>:exec SessionSave()<CR><ESC>
endif

" version 7+ commands
if version >= 700
   " spelling is configured yet disabled by default
   setlocal nospell
   " set a spell file where new words are added with 'zg'
   set spellfile=~/.vim.spell.add

   " the following enables spelling with F7 and disables it with shift-F7
   nnoremap <silent> <F7> <ESC>:setlocal spell spelllang=en_us<CR>
   nnoremap <silent> <S-F7> <ESC>:setlocal nospell<CR>

   " map shift-left to previous tab and shift-right to next tab
   nnoremap <silent> <S-left> <ESC>:tabp<CR>
   nnoremap <silent> <S-right> <ESC>:tabn<CR>
endif

" configure the Tag List plugin
let Tlist_Highlight_Tag_On_BufEnter=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_File_Fold_Auto_Close=0
let Tlist_Process_File_Always=1
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=1
let Tlist_Show_One_File=0
let Tlist_Auto_Update=1
let Tlist_Auto_Open=0
let Tlist_Use_SingleClick = 1
" F3 shows the taglist (and disables spell check), shift-F3 turns it off
" to install run the following under Ubuntu: vim-addons install taglist
nnoremap <silent> <F3> <ESC>:TlistOpen<CR>:setlocal nospell<CR>
nnoremap <silent> <F8> <ESC>:TlistToggle<CR>  
nnoremap <silent> <S-F3> <ESC>:TlistClose<CR>
if has("cscope")
   " ctrl-shift-F3 reloads the cscope database from the current directory
   nnoremap <silent> <C-S-F3> <ESC>:echo "rebuilding cscope database..."<CR>:call system("cscope -qbR")<CR>:cs kill -1<CR>:<CR>:cs add .<CR>
endif

" F6 selects all text and copies it to the clipboard, shift-F6 does a paste, also
" restoring the position which is lost during the select all
nnoremap <silent> <F6> <ESC>:let save_cursor = getpos(".")<ESC>ggVG"+y:call setpos('.', save_cursor)<CR>
nnoremap <silent> <S-F6> <ESC>:let save_cursor = getpos(".")<ESC>ggVG"+gP:call setpos('.', save_cursor)<CR>

" F9 performs an CVS/SVN diff using the vcscommand plugin, shift-F9 cancels the diff
" to install run the following under Ubuntu: vim-addons install vcscommand
let VCSCommandDeleteOnHide=1
let VCSCommandEdit='split'
nnoremap <silent> <F9> <ESC>:execute ':VCSVimDiff'<CR>
nnoremap <silent> <S-F9> <ESC>:execute ':VCSGotoOriginal!'<CR>

" F10 is mapped to the cumbersome chore of inserting a doxygen header with CVS fields with my credentials
nnoremap <silent> <F10> <ESC>:1<ESC>i<C-R>="/*\! \\file    " . substitute(bufname("%"), "^.*\/", "", "g") . "\n \\brief   \n\\author  Rod Moffitt\n\\date    \$Date\$\n\\version \$Revision\$ */\n\n/\*\ $Id\$\nCopyright (C) " . substitute(system("date +'%G'"), "\n", "", "g") . " Rod Moffitt rod@rod.info http://rod.info */\n\n" <CR><ESC><CR>
" shift-F10 is mapped to another ritual of appending my vim preferences to the end of the file
nnoremap <silent> <S-F10> <ESC>:$<ESC>o<CR>/* vim: sw=3 ts=3 expandtab<CR><BS><BS><BS> */<ESC>

" F11 toggles the menu on and off, shift-F11 toggles the toolbar and
" ctrl-shift-F11 toggles the vertical scrollbar (all of which are
" disabled by default in this vimrc)
nnoremap <silent> <F11> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <silent> <S-F11> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <silent> <C-S-F11> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
" ==================Added by QuyenDV====================================================
":hi CursorLine   term=NONE cterm=NONE ctermbg=LightCyan ctermfg=NONE guibg=LightCyan guifg=NONE
"set colorcolumn=81
":hi colorcolumn ctermbg=LightGrey
" Set color of number
:hi LineNr ctermfg=DarkGrey
":nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
filetype plugin on
