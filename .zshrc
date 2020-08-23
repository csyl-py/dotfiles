export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
#export QT_FONT_DPI=192
#Set keyboard to vi mode
bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-backward
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
HISTCONTROL=ignoredups

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt autocd
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/salo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


autoload -U promptinit
promptinit
# This will set the default prompt to the walters theme
prompt walters


# Set Environment variables
export BROWSER=qutebrowser
export VISUAL=kak
export EDITOR=kak



autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
unalias run-help
alias help=run-help


zstyle ':completion:*' rehash true

export WINEPREFIX=$HOME/.config/wine/
#export WINEARCH=win32
source  ~/powerlevel9k/powerlevel9k.zsh-theme

#fzf binds
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

#scripts ejecutables
PATH=~/.scripts:${PATH}
export PATH

#Powerlevel9k right prompt show current vi mode
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode)

#To find and play audio straight from terminal with mm "search terms"
function mm() {
    mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch10:"$@"
}

fo() {
  local out file key
  out=$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

#Lazy neovim
alias v="nvim"

alias ls='ls --color=auto'

#Zsh: change directory using ranger
 ranger-cd() {
     tempfile=$(mktemp)
     ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
     test -f "$tempfile" &&
     if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
       cd -- "$(cat "$tempfile")"
     fi
     rm -f -- "$tempfile"
   }

   # This binds Ctrl-O to ranger-cd:
#   zle -N ranger-cd
#   bindkey '^o' ranger-cd
alias ranger="ranger-cd"


#Zsh: change directory using lf
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
alias lf="lfcd"
alias trr="transmission-remote"

#solarized ls lf https://github.com/joel-porquet/zsh-dircolors-solarized 
source ~/.zsh/zsh-dircolors-solarized/zsh-dircolors-solarized.zsh

#nnn cd
export NNN_BMS='a:/mnt/expansion3tb/anime/;k:/home/salo/Downloads/'
export NNN_TRASH=1 # trash (needs trash-cli) instead of delete
export NNN_ARCHIVE="\\.(7z|bz2|gz|tar|tgz|zip)$"
#export NNN_PLUG='x:_mpv $nnn'

alias aw2="/home/salo/Downloads/test"
#export NNN_PLUG='x:_aw1 $nnn'
export NNN_PLUG='x:_aw1 $nnn'
alias nnn="nnn -r"
n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

source /home/salo/.config/broot/launcher/bash/br
alias paci="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
source /home/salo/scripts/zsh-interactive-cd.plugin.zsh
alias cf='fd -tf . ~/.config/ | fzf |xargs -r $EDITOR ;'
