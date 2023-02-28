set nocompatible
" base
" 文字コードをUTF-8に設定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8


" Plugin
call g:plug#begin()
" colorshckema
Plug 'NLKNguyen/papercolor-theme'   
" Snipet Plugin 
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" autobracket
Plug 'jiangmiao/auto-pairs'

" coc
" https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" markdown
Plug 'iamcco/markdown-preview.vim'
Plug 'iamcco/mathjax-support-for-mkdp'
" Julia Plugin
Plug 'JuliaEditorSupport/julia-vim'
Plug 'JuliaLang/julia-vim'
Plug 'AtsushiSakai/julia.vim'
" Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
"  Plug 'roxma/nvim-completion-manager'  " optional

" Python
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }

"  File Explorer
" https://github.com/preservim/nerdtree 
Plug 'preservim/nerdtree'
" Plug 'lambdalisue/glyph-palette.vim'

" Airplane
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call g:plug#end()


" 見た目
" 行を表示
set number
set ruler
" シンタックスオン
syntax enable
" インデントはスマートインデント
set smartindent
" 括弧入力時に対応する括弧を表示
set showmatch
" ステータスラインを常に表示する
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" インサートモード中の<Esc>をjjに変更する
inoremap <silent> jj <ESC>
" 折り返し時に表示行単位での移動をできるように
nnoremap j gj
nnoremap k gk
" ビープ音を消す
set belloff=all

" tabについて
" Tabを半角文字にする
set expandtab
" 行頭以外のTab文字の表示幅
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4
" 現在のインデントをキープする
set autoindent


" 検索系
" 検索文字列が小文字の場合は大文字小文字の区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれているなら区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索後をハイライト表示
set hlsearch
" EXC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc> 

" 入力系
" バックスペースを使いやすくする
set backspace=2

" クリップボードの使用を可能にする
set clipboard+=unnamed

" Ultisnipes
"let g:UltiSnipsExpandTrigger='<c-k>' " デフォルトは<tab>
let g:UltiSnipsJumpForwardTrigger='<c-n>' 
let g:UltiSnipsJumpBackwardTrigger='<c-p>' 
" let g:UltiSnipsEditSplit='vertical' " スニペットの編集する時にウィンドウを縦に分割する



" <F5> でコード実行
function! Exe()
    echo "Exe"
    let filename = expand('%:t')
    if stridx(filename, ".py") != -1
        !python %
    elseif stridx(filename, ".jl") != -1
        !julia %
    else
        echo "unknown filetype"+filename
    endif
endfunction
command! Exe :call Exe()
nmap <F5> :Exe

" Julia language server 
" https://github.com/julia-vscode/LanguageServer.jl


" colorscheme
set t_Co=256
set background=dark
colorscheme PaperColor
" 背景を透明にする
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight SpecialKey ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
set cursorline
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
"highlight CursorLine cterm=underline ctermfg=Red ctermbg=Red
"highlight CursorLine guifg=Red guibg=Red
" let g:onedark_termcolors=256

" julia
let g:default_julia_version = '1.8'

" language server
let LanguageClient_autoStart = 1
let LanguageClient_serverCommands = {
\   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
\       using LanguageServer;
\       using Pkg;
\       import StaticLint;
\       import SymbolServer;
\       # プロジェクトを読み込むようにする．なければそのまま．
\       # ディレクトリがsrcなら一つ上の階層に上がる
\       activate_dir = "./"
\       if pwd()[end-2:end] == "src";
\           activate_dir = "../";
\       end;
\       # もし今のディレクトリに `Project.toml` があるならactivateする
\       flag = false;
\       for file_name in readdir(activate_dir);
\           if file_name == "Project.toml";
\               flag = true;
\           end;
\       end;
\       if flag;
\           Pkg.activate(activate_dir);
\       end;
\       env_path = dirname(Pkg.Types.Context().env.project_file);
\       server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path, "");
\       server.runlinter = true;
\       run(server);
\   ']
\ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>


" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" 定義元ジャンプ
" https://wonderwall.hatenablog.com/entry/2019/08/17/003000#定義元ジャンプ
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Setting vim-vsnip
" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
" imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
" smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
