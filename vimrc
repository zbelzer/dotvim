call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible
syntax on
filetype plugin indent on
compiler ruby

set hlsearch
" set number
set showmatch
set incsearch
set background=dark
set hidden
set backspace=indent,eol,start
set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set dir=/tmp
set nowrap
set scrolloff=5

set spell

set laststatus=2
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path
set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10(L(%l/%L)%)\           " line
set statusline+=%2(C(%v/125)%)\           " column
set statusline+=%P                        " percentage of file

let html_use_css=1
let html_number_lines=0

let g:rubycomplete_buffer_loading = 1
let g:no_html_toolbar = 'yes'

" RSpec
let g:rspec_command = "!rspec --no-profile --no-color -f p {spec}"

" Gist
if has("gui_macvim")
  let g:gist_clip_command = 'pbcopy'
else
  let g:gist_clip_command = 'xclip -selection clipboard'
endif

let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1

" Command-T
" nmap <silent> <leader>t :CommandTFlush<CR>:CommandT<CR>
" let g:CommandTMatchWindowAtTop=1

" Ctrl-P
nmap <silent> <leader>t :CtrlP<CR>
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:10,results:10'

" Ack
" let g:ackprg="ack -H --nocolor --nogroup --column --nosql --ignore-dir=tmp --ignore-dir=stress --ignore-dir=doc --ignore-dir=coverage"

" Ag
" let g:agprg="<custom-ag-path-goes-here> --column"

" Rspec
map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

set wildignore+=*.o,*.obj,.git,tmp,stress,db/sphinx,vendor/cache,doc,spec/fixtures,coverage
let g:HammerQuiet=1

colorscheme molokai

noremap <F3> :source $MYVIMRC<CR>
noremap <F2> :sp $MYVIMRC<CR>
autocmd! bufwritepost .vimrc source %

au BufRead,BufNewFile *.scss set filetype=scss
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType tex setlocal textwidth=78
autocmd BufNewFile,BufRead *.txt setlocal textwidth=78
autocmd BufLeave <buffer> silent! ruby $command_t.leave

" Restore cursor position
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

autocmd FileType ruby runtime ruby_mappings.vim
map <silent> <LocalLeader>cj :!clj %<CR>
map <silent> <LocalLeader>rt :!ctags -R --exclude=".git\|.svn\|log\|tmp\|db\|pkg" --extra=+f<CR>
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>
map <silent> <LocalLeader>gd :e product_diff.diff<CR>:%!git diff<CR>:setlocal buftype=nowrite<CR>
map <silent> <LocalLeader>pd :e product_diff.diff<CR>:%!svn diff<CR>:setlocal buftype=nowrite<CR>
map <silent> <LocalLeader>nh :nohls<CR>
map <LocalLeader>aw :Ag <C-R><C-W> 
map <silent> <LocalLeader>bd :bufdo :bd<CR>
map <silent> <LocalLeader>cc :TComment<CR>
map <silent> <LocalLeader>uc :TComment<CR>
cnoremap <Tab> <C-L><C-D>

nmap <LocalLeader>a= :Tab /=<CR>
vmap <LocalLeader>a= :Tab /=<CR>
nmap <LocalLeader>a, :Tab /,<CR>
vmap <LocalLeader>a, :Tab /,<CR>
nmap <LocalLeader>a: :Tab /:\zs<CR>
vmap <LocalLeader>a: :Tab /:\zs<CR>
nmap <LocalLeader>a> :Tab /=><CR>
vmap <LocalLeader>a> :Tab /=><CR>

map <silent> <LocalLeader>h :Hammer<CR>

" ctrl-space for suggestions
inoremap <C-Space> <C-N>

" Page using space like less
noremap <Space> <C-F>

noremap Q @q

if version >= 700
  autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us
  autocmd FileType tex setlocal spell spelllang=en_us
endif

" Just in case I'm on a mac
if has("gui_running") && has("mac")
  set fuopt=maxhorz,maxvert
end
