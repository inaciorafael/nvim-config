let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Projects/digital-hub/packages/hub-shared
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +248 src/components/AccountOverviewCard/AccountOverviewCard.tsx
badd +67 src/retailAccounts/components/NutrienProtocolBanner/NutrienProtocolBanner.tsx
badd +43 src/hooks/useNutrienProtocol/useNutrienProtocol.tsx
badd +34 ~/Projects/digital-hub/packages/hub-ecomm/src/features/cart-add-or-edit-item/components/NutrienProtocolBanner/NutrienProtocolBanner.tsx
badd +24 ~/Projects/digital-hub/packages/hub-ecomm/src/features/cart-add-or-edit-item/components/NutrienProtocolBanner/NutrienProtocolBannerContent.tsx
argglobal
%argdel
edit ~/Projects/digital-hub/packages/hub-ecomm/src/features/cart-add-or-edit-item/components/NutrienProtocolBanner/NutrienProtocolBanner.tsx
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 40 + 75) / 151)
exe 'vert 2resize ' . ((&columns * 110 + 75) / 151)
tcd ~/Projects/digital-hub/packages/hub-ecomm
argglobal
enew
file ~/Projects/digital-hub/packages/hub-shared/neo-tree\ filesystem\ \[1]
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
wincmd w
argglobal
balt ~/Projects/digital-hub/packages/hub-ecomm/src/features/cart-add-or-edit-item/components/NutrienProtocolBanner/NutrienProtocolBannerContent.tsx
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 32 - ((12 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 32
normal! 0
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 40 + 75) / 151)
exe 'vert 2resize ' . ((&columns * 110 + 75) / 151)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
