function print_err() {
    if [[ "$DISPLAY_PROG_IN_ERR" == "1" ]] ; then
        echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] (ERROR) $0: $@" >&2
    else
        echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] (ERROR): $@" >&2
    fi
}
