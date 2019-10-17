alias tmutt='tmux attach-session -t mutt'
alias tirssi='tmux attach-session -t irssi'
alias troot='tmux attach-session -t root'
alias tjails='tmux attach-session -t jails'
alias tfullscreen='tmux attach-session -t fullscreen'
alias tlist='echo "Session list [tmux list-session].." && tmux list-session'
alias lstmux='echo "Session list [tmux list-session].." && tmux list-session'

# dont need this tmux alias no mo' - in fact, it breaks tmux, because of the TERM setting (cant open terminfo db)
# Fri Oct 19 09:09:05 EDT 2018
# alias tmux='TERM=tmux tmux -u'


function tatt()
{
#    _tmux=$(which tmux)
    _tmux=/usr/local/bin/tmux
    detach=yes
    s="$@"

    if [ -z "${_tmux}" ]; then
        echo "tmux not found"
        return 1
    fi

    if [ -z "$s" ] ; then
        echo "Usage: tatt session-name"
        echo ""
        echo "Current sessions: "
        $_tmux list-session > /tmp/tms.$$ 2> /dev/null
        if [ -s /tmp/tms.$$ ] ; then 
            cat /tmp/tms.$$
        else
            echo " None found!"
        fi
        rm -f /tmp/tms.$$
        return 1
    fi

    if [ "$1" = "-n" ] ; then
        detach=no
        shift
    fi

    sessions=$(tmux list-sessions | awk -F: '{ print $1 }')
    if echo "$sessions" | egrep "^${s}$|^${s}\W|\W${s}\W|${s}$" > /dev/null 2>&1 ; then
        if [ "$detach" = "yes" ] ; then
            echo "First, detaching clients from '$s' [tmux detach-client -s '$s'].. (you can use the '-n' flag to prevent this).."
            ${_tmux} detach-client -s "$s"
        fi
        echo "Attaching to existing session '$s' [tmux attach-session -t '$s'].."
        ${_tmux} -u -f ~/.tmux.conf attach-session -t "$s"
    else
        echo "Creating new session '$s' [tmux new-session -t \"$s\"].."
        ${_tmux} -u -f ~/.tmux.conf new-session -s "$s"
    fi

}




function tdet()
{
#    _tmux=$(which tmux)
    _tmux=/usr/local/bin/tmux
    s="$*"

    if [ -z "${_tmux}" ]; then
        echo "tmux not found"
        return 1
    fi

    if [ -z "$s" ] ; then
        echo "Usage: tdet session-name"
        return 1
    fi

    sessions=$(tmux list-sessions | awk -F: '{ print $1 }')
    if echo "$sessions" | egrep "^${s}$|^${s}\W|\W${s}\W|${s}$" > /dev/null 2>&1 ; then
        echo "Detaching clients from '$s' [tmux detach-client -s '$s'].."
        ${_tmux} detach-client -s "$s"
    else
        echo "Session '$s' not found. No detach ran."
    fi

}
