" vim-panemaxx - Maximizes and restores the current pane
" Original Author:   Szymon Wrozynski and vim-maximiser contributors
" Modified By: Jitin Nair
" Version:      1.0
"
" Modifications Made:
" - Bugfixes to the window resize logic
" - changed command to :PaneMaxx
"
" License:
" Distributed under the same terms as Vim itself.
" See :help license
"
" Usage:
" See :help panemaxx
" https://github.com/jitinair1/vim-panemaxx/blob/master/README.md

if exists('g:loaded_vim_maximizer') || &cp || v:version < 700
    finish
endif

let g:loaded_vim_maximizer = 1

if !exists('g:maximizer_set_default_mapping')
    let g:maximizer_set_default_mapping = 1
endif

if !exists('g:maximizer_default_mapping_key')
    if exists('g:mapleader')
        let g:maximizer_default_mapping_key = '<Leader>z'
    else
        let g:maximizer_default_mapping_key = '<F3>'
    endif
endif

command! -nargs=0 -range PaneMaxx :call s:toggle(0)

if g:maximizer_set_default_mapping
    let command = ':PaneMaxx'

    silent! exe 'nnoremap <silent>' . g:maximizer_default_mapping_key . ' ' . command . '<CR>'
    silent! exe 'vnoremap <silent>' . g:maximizer_default_mapping_key . ' ' . command . '<CR>gv'
    silent! exe 'inoremap <silent>' . g:maximizer_default_mapping_key . ' <C-o>' . command . '<CR>'
endif

fun! s:maximize()
    if exists('*win_gettype') && win_gettype() == 'popup'
        let w:maximizer_save = popup_getoptions(win_getid())
        call popup_move(win_getid(), {'line': 1, 'col': 1, 'minwidth': &columns, 'minheight': &lines, 'maxwidth': &columns, 'maxheight': &lines})
    else
        let t:maximizer_sizes = { 'before': winrestcmd(), 'count': winnr('$') }
        vert resize | resize
        let t:maximizer_sizes.after = winrestcmd()
        normal! ze
    endif
endfun

fun! s:restore()
    if exists('*win_gettype') && win_gettype() == 'popup'
        if exists('w:maximizer_save')
            call popup_setoptions(win_getid(), w:maximizer_save)
            unlet w:maximizer_save
        endif
    elseif exists('t:maximizer_sizes')
        if t:maximizer_sizes.count == winnr('$')
            silent! exe t:maximizer_sizes.before
            if t:maximizer_sizes.before != winrestcmd()
                wincmd =
            endif
        else
            exe 'wincmd ='
            redraw!
            echomsg "PaneMaxx: Layout changed, equalizing windows."
        endif
        unlet t:maximizer_sizes
        normal! ze
    endif
endfun

fun! s:toggle(force)
    if exists('*win_gettype') && win_gettype() == 'popup'
        if exists('w:maximizer_save')
            call s:restore()
        else
            call s:maximize()
        endif
        return
    endif

    if exists('t:maximizer_sizes')
        call s:restore()
    elseif winnr('$') > 1
        call s:maximize()
    endif
endfun
