setopt share_history


export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000000
setopt EXTENDED_HISTORY
setopt share_history

bindkey -e

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# pure
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# asdf
zinit light asdf-vm/asdf
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit
[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ] && source /opt/homebrew/opt/asdf/libexec/asdf.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [[ -x "/usr/bin/fzf" ]]; then
  incremental_search_history() {
    selected=`history -E 1 | fzf | cut -b 26-`
    BUFFER=`[ ${#selected} -gt 0 ] && echo $selected || echo $BUFFER`
    CURSOR=${#BUFFER}
    zle redisplay
  }
  zle -N incremental_search_history
  bindkey "^R" incremental_search_history
fi

export EDITOR=vim
export PATH="$PATH:$HOME/.local/bin:$HOME/bin"

# gh
[ -x /opt/homebrew/bin/gh ] && eval "$(gh completion -s zsh)"

# gcloud
[ -f "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc" ] && source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
[ -f "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc" ] && source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# ngrok
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

export PATH="$PATH:$HOME/.local/bin:$HOME/bin"
export GPG_TTY=$(tty)

# ssh-agent proxy for WSL2
if [[ ! -z "$WSL_DISTRO_NAME" && -x "$HOME/.ssh/wsl2-ssh-pageant.exe" ]]; then
	export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
	ss -a | grep -q $SSH_AUTH_SOCK
	if [ $? -ne 0 ]; then
		rm -f $SSH_AUTH_SOCK
		(setsid nohup socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:$HOME/.ssh/wsl2-ssh-pageant.exe >/dev/null 2>&1 &)
	fi
fi
