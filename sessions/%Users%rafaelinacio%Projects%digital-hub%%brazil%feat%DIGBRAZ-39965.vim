let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Projects/digital-hub
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +654 packages/hub-shared/src/lang/pt.json
badd +226 packages/hub-shared/src/components/AccountOverviewCard/AccountOverviewCard.tsx
badd +29 packages/frontends-br/hub-insurance/src/routes.ts
badd +1 ~/Projects/digital-hub/packages/hub-accounts/src/components/views/CreditRequest/index.tsx
badd +124 ~/Projects/digital-hub/packages/hub-accounts/src/components/views/CreditRequest/CreditRequest.tsx
badd +47 ~/Projects/digital-hub/packages/hub-accounts/src/components/molecules/CreditRequest/CreditRequestHeader/CreditRequestHeader.tsx
badd +167 ~/Projects/digital-hub/packages/hub-shared/src/retailAccounts/components/AccountSelector/AccountSelector.tsx
argglobal
%argdel
edit packages/hub-shared/src/components/AccountOverviewCard/AccountOverviewCard.tsx
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
argglobal
enew
file neo-tree\ filesystem\ \[1]
balt packages/hub-shared/src/lang/pt.json
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
balt ~/Projects/digital-hub/packages/hub-accounts/src/components/molecules/CreditRequest/CreditRequestHeader/CreditRequestHeader.tsx
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
let s:l = 198 - ((29 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 198
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
