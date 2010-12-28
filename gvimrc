colorscheme vividchalk

if has("gui_macvim")
  set guifont=Monaco:h12.00
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
else
  set gfn=DejaVu\ Sans\ Mono\ Bold\ 10
endif

noremap <C-V> "+p
inoremap <C-V> <ESC>"+p<CR>i

" Quiet terminal bell
set vb t_vb=
set noerrorbells

set guioptions-=T  "remove toolbar
set guioptions-=m  "remove menu
