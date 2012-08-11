alias ls="ls -FG"
alias la="ls -a"
alias ll="ls -l"
alias vi="vim"
alias q="exit"


PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
PATH=/opt/local/bin:/opt/local/apache2/bin:$PATH
PATH=$HOME/local/bin:$PATH
export PATH=$PATH

MANPATH=$HOME/local/share/man:$HOME/local/man:/opt/local/share/man
MANPATH=$MANPATH:/usr/share/man:/usr/local/share/man:/usr/X11/man:/usr/X11/lib/X11/man:/usr/X11/share/man
export MANPATH=$MANPATH
export LANG=ja-JP.UTF-8
