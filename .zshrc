LANG=ja_JP.UTF-8; export LANG
PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:$HOME/bin:$HOME/.cabal/bin; export PATH
EDITOR=vim; export EDITOR

bindkey -e
autoload -Uz compinit; compinit
setopt auto_pushd
setopt append_history
setopt print_eight_bit
setopt share_history
setopt hist_ignore_all_dups

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt share_history
function history-all { history -E 1 }

PROMPT='['${WINDOW:+${WINDOW}|}$USER'@%M:%~]%# '
RPROMPT='<%T>'
PROMPT2='%_>'

REPORTTIME=30

agent="$HOME/.tmp/ssh-agent/`hostname`"
if [ -S "$agent" ]; then
    export SSH_AUTH_SOCK=$agent
elif [ ! -S "$SSH_AUTH_SOCK" ]; then
    echo "no ssh-agent"
elif [ ! -L "$SSH_AUTH_SOCK" ]; then
    ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
fi

source $HOME/perl5/perlbrew/etc/bashrc

[[ -s "/home/nakayama/.rvm/scripts/rvm" ]] && source "/home/nakayama/.rvm/scripts/rvm"  # This loads RVM into a shell session.

