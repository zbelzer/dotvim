colorscheme molokai

if has("gui_macvim")
  set guifont=Monaco:h12.00
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
else
  set gfn=DejaVu\ Sans\ Mono\ Bold\ 10
endif

inoremap <C-S-V> "+p
inoremap <C-S-V> <ESC>"+p<CR>i

" Quiet terminal bell
set vb t_vb=
set noerrorbells

set guioptions-=T  "remove toolbar
set guioptions-=m  "remove menu
set number
