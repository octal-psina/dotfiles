# .bashrc

# for setting history length 
HISTSIZE=5000
HISTFILESIZE=10000

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

#nvim mode
set -o vi

#my aliases
#git --bare repo
alias config='/usr/bin/git --git-dir=$HOME/dotfiles_fedora.git/ --work-tree=$HOME'
unset rc
alias vim="nvim"
alias ll="ls -la"
#zoxide
alias cd="z"
#lsdeluxe
alias ls="lsd -F"
alias la="lsd -AF"
alias ll="lsd -lAF"
alias lg="lsd -F --group-dirs=first"
alias tree="lsd -AF --tree"

#default apps
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

#auto start 
fastfetch &&
shopt -s cdspell 
eval "$(starship init bash)"
eval "$(zoxide init bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"
