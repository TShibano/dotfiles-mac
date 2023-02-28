# zshでvim modewp使う
bindkey -v
bindkey "jj" vi-cmd-mode

#### alias 
#### alias application ### Mac application
alias memo='open -a /Applications/memo.app'
alias safari='open -a /Applications/Safari.app'
alias reminder='open -a /Applications/reminder.app'
alias calender='open -a /Applications/calender.app'
alias mail='open -a /Applications/mail.app'
alias dictionary='open -a /Applications/dictionary.app'

### Other application
alias vim='/usr/local/bin/vim'
alias google='open -a /Applications/"Google Chrome.app"'
alias zoom='open -a /Applications/"zoom.us.app"'
alias music='open -a /Applications/music.app'
alias line='open -a /Applications/LINE.app'
alias kindle='open -a /Applications/Kindle.app'

alias r1='open -a Safari https://qiita.com/e869120/items/eb50fdaece12be418faa'
alias aldocker='open -a /Applications/Docker.app'
alias slack='open -a /Applications/Slack.app'
alias routine='r1 && slack && aldocker'


### programing
alias rstudio='open -a /Applications/Rstudio.app'

### terminal IDE
#alias ide='zsh ~/.scripts/ide.sh'
alias tmuxide='tmux new -s $1 \; source-file ~/.scripts/new_session'


# alias change directory
alias cddata='cd ~/Data_Analysis/DataAnalysis'

export PS1="%~ $ "


# pyenvさんに~/.pyenvではなく、/usr/loca/var/pyenvを使うようにお願いする
#export PYENV_ROOT=/usr/local/var/pyenv
# export PYENV_ROOT=~/.pyenv
eval "$(pyenv init -)"

# pyenvさんに自動補完機能を提供してもらう
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# rbenv
# [[ -d ~/.ebenv ]] && \
    # export PATH=${HOME}/.rbenv/bin:${PATH} && \
    # eval "$(rbenv init - )"

eval "$(rbenv init - zsh)"

# Julia の path
export PATH=${PATH}:/Applications/Julia-1.8.app/Contents/Resources/julia/bin

# Tex Liveのpath
export PATH=/usr/local/texlive/2020/bin/x86_64-darwin:$PATH
export MANPATH=/usr/local/texlive/2020/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2020/texmf-dist/doc/info:$INFOPATH 


# Starship
eval "$(starship init zsh)"

# gitの補完 ====
# brew の場合
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
#
# 補完機能有効にする
autoload -U compinit
compinit -u
 
# 補完候補に色つける
autoload -U colors
colors
zstyle ':completion:*' list-colors "${LS_COLORS}"
 
# 単語の入力途中でもTab補完を有効化
setopt complete_in_word
# 補完候補をハイライト
zstyle ':completion:*:default' menu select=1
# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true
# 大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完リストの表示間隔を狭くする
setopt list_packed
 
# コマンドの打ち間違いを指摘してくれる
setopt correct
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [Yes/No/Abort/Edit] => "
# ====
