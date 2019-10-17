# had to disable this because it breaks the vim man plugin / script
#

export COOL_MAN_PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

# easier to type (slightly)
alias gvi=gvim

# osx compatibility
alias mvi=gvim
alias mvim=mvim
