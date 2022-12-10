# making it prettier
if [[ $TERM == xterm ]]; then TERM=xterm-256color; fi
set t_Co=256

# History in cache directory:
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.cache/.zsh_history

# tmux and zsh history sync
setopt CORRECT
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY

zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_DATA_HOME/zsh/.zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.
# Basic auto/tab complete:
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
complete -C '/usr/bin/aws_completer' aws

# cd with just Filename
setopt autocd

source $ZDOTDIR/bash-my-aws/aliases
source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/zsh-colored-man-pages/zsh-colored-man-pages.zsh
source $ZDOTDIR/aws_zsh_completer.zsh
source $ZDOTDIR/lfcd.sh
# source $ZDOTDIR/wp-completion.bash

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

### SpaceShip settings ###

# using spaceship
source $ZDOTDIR/spaceship-prompt/spaceship.zsh

# settings
SPACESHIP_AWS_SHOW=true
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_12HR=true
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_CHAR_SYMBOL=$
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_HG_SHOW=false
SPACESHIP_PACKAGE_SHOW=true
SPACESHIP_NODE_SHOW=true
SPACESHIP_RUBY_SHOW=false
SPACESHIP_ELM_SHOW=false
SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_XCODE_SHOW_LOCAL=false
SPACESHIP_SWIFT_SHOW_LOCAL=false
SPACESHIP_GOLANG_SHOW=true
SPACESHIP_PHP_SHOW=false
SPACESHIP_RUST_SHOW=false
SPACESHIP_JULIA_SHOW=false
SPACESHIP_DOCKER_SHOW=true
SPACESHIP_DOCKER_CONTEXT_SHOW=false
SPACESHIP_CONDA_SHOW=false
SPACESHIP_VENV_SHOW=true
SPACESHIP_PYTHON_SHOW=true
SPACESHIP_DOTNET_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_KUBECTL_CONTEXT_SHOW=false
SPACESHIP_TERRAFORM_SHOW=true
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_JOBS_SHOW=true
SPACESHIP_DIR_TRUNC=3


# fzf setup
source $ZDOTDIR/fzf/completion.zsh
source $ZDOTDIR/fzf/key-bindings.zsh

### Personal list of alias ###

  # better command alternative
alias s='bat'
alias tree='tree --dirsfirst -C'
alias diff='diff --color'
alias grep='grep --color'

alias gitd='/usr/bin/git --git-dir=$HOME/.cfg/.git/ --work-tree=$HOME'

alias pacman='sudo pacman'
alias openvpn='sudo openvpn'
alias gotop='TERM=xterm-kitty gotop'
alias kill='sudo kill'

    # faster
alias l='exa --icons -lh --group-directories-first'
alias ll='exa --icons -lh --grid --group-directories-first'
alias la='exa --icons --group-directories-first -lah --grid'
alias v='nvim'
alias c='clear'
alias cl='clear && l'
alias ca='clear && la'
alias f='lfcd'
alias sp='tmux split -h'
alias t='tree -d -L 4'
alias p='ipython'
alias vv='nvim $(rg -l "" ~/.config/nvim | fzf)'
alias vw='nvim ~/Documents/.vimwiki/index.md'
alias vz='nvim ~/.config/zsh/.zshrc'
alias vk='nvim ~/.config/sxhkd/sxhkdrc'
alias vh='nvim ~/.cache/.zsh_history'
alias vl='nvim ~/.config/lf/lfrc'
alias vs='nvim -o $(find /home/vinny/.config/nvim/pluggin/vim-snippets/snippets -type f | fzf)'
alias va='nvim ~/.config/alacritty/alacritty.yml'
alias vt='nvim ~/.config/tmux/tmux.conf'
alias ft='nvim -o $(find ~/Documents/dotoo-files/ -type f -not -path "*/.git/*" | fzf)'
alias gl='git log --all --decorate --graph'
alias b='mpv ~/Musics/Alarm_Clock_Sound_Effect.ogg'
alias tc='tar zcvf'
alias tx='tar zxvf'
alias sd='sr duckduckgo'
alias sg='sr google'
alias vj='nvim ~/Documents/.Journal/'
alias todo='nvim ~/Code/todo.conky/todo/todo.md'

alias tmux='tmux -f ~/.config/tmux/tmux.conf'
alias re='ffmpeg -f x11grab -s 2160x1350 -i :0.0 -f alsa -i hw:0'
# alias re='ffmpeg -f x11grab -s 2160x1350 -probesize 42M -i :0.0 -f pulse -ac 2 -i 6'
# alias re='ffmpeg -f x11grab -s 1980x1080 -probesize 42M -i :0.0 -f pulse -ac 2 -i 7'


# eval "$(lua ~/.config/zsh/z.lua/z.lua --init zsh)"
#ecompar
eval "$(lua ~/.config/zsh/z.lua/z.lua --init zsh enhanced once)"
_SILENT_JAVA_OPTIONS="$_JAVA_OPTIONS" && unset _JAVA_OPTIONS && alias java='java "$_SILENT_JAVA_OPTIONS"'

# uncomment when using node
# source /usr/share/nvm/init-nvm.sh
# source "/home/vinny/.sdkman/bin/sdkman-init.sh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$XDG_DATA_HOME/.sdkman"
[[ -s "$XDG_DATA_HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$XDG_DATA_HOME/.sdkman/bin/sdkman-init.sh"

source /home/vinny/.config/broot/launcher/bash/br
