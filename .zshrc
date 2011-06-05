LANG=ja_JP.UTF-8; export LANG
PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:$HOME/bin:$HOME/.abal/bin; export PATH
EDITOR=vim; export EDITOR

autoload -Uz compinit; compinit
setopt auto_pushd
setopt append_history
setopt print_eight_bit
setopt share_history

PROMPT='['${WINDOW:+${WINDOW}|}$USER'@%M:%~]%# '
RPROMPT='<%T>'
PROMPT2='%_>'

