LANG=ja_JP.UTF-8; export LANG
PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:$HOME/bin:$HOME/.cabal/bin; export PATH
EDITOR=vim; export EDITOR

bindkey -e
autoload -Uz compinit; compinit
autoload -Uz VCS_INFO_get_data_git
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

# http://d.hatena.ne.jp/uasi/20091025/1256458798
VCS_INFO_get_data_git 2> /dev/null

setopt prompt_subst
setopt re_match_pcre

function rprompt-git-current-branch {
        local name st color gitdir action
        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
                return
        fi
        name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
        if [[ -z $name ]]; then
                return
        fi

        gitdir=`git rev-parse --git-dir 2> /dev/null`
        action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

        st=`git status 2> /dev/null`
	if [[ "$st" =~ "(?m)^nothing to" ]]; then
                color=%F{green}
	elif [[ "$st" =~ "(?m)^nothing added" ]]; then
                color=%F{yellow}
	elif [[ "$st" =~ "(?m)^# Untracked" ]]; then
                color=%B%F{red}
        else
                 color=%F{red}
         fi

              
        echo "$color$name$action%f%b "
}
#

PROMPT='['${WINDOW:+${WINDOW}|}$USER'@%M:%~]%# '
RPROMPT='<`rprompt-git-current-branch`%T>'
PROMPT2='%_>'

REPORTTIME=30

agent="$HOME/.tmp/ssh-agent/`hostname`"
if [ -S "$agent" ]; then
    export SSH_AUTH_SOCK=$agent
elif [ ! -S "$SSH_AUTH_SOCK" ]; then
    echo "no ssh-agent"
elif [ ! -L "$SSH_AUTH_SOCK" ]; then
    mkdir -p `dirname $agent`
    ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
fi

[[ -s "$HOME/perl5/perlbrew/etc/bashrc" ]] && source "$HOME/perl5/perlbrew/etc/bashrc"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
[[ -d "$HOME/.rvm/bin" ]] && export PATH=$PATH:$HOME/.rvm/bin

[[ -d "$HOME/.rbenv/bin" ]] && export PATH="$HOME/.rbenv/bin:$PATH" && eval "$(rbenv init -)"

[[ -d "$HOME/.nodebrew/current/bin" ]] && export PATH="$HOME/.nodebrew/current/bin:$PATH"

if [ -d "$HOME/.pyenv/bin" ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

if [ -d "$HOME/.pyenv/shims" ]; then
    export PATH="$HOME/.pyenv/shims:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

[[ -d "$HOME/usr/terraform" ]] && export PATH="$HOME/usr/terraform:$PATH"

[[ -s "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" ]] && source /usr/share/virtualenvwrapper/virtualenvwrapper.sh 

[[ -s "$HOME/.nvm/nvm.sh" ]] && export NVM_DIR="$HOME/.nvm" && source "$NVM_DIR/nvm.sh"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -x "/usr/bin/ack-grep" ]] && alias ack="ack-grep"

[[ -x "/usr/local/bin/direnv" ]] && eval "$(direnv hook zsh)"

alias be="bundle exec"



