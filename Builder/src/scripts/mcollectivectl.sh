#!/bin/bash
# Script to prevent mcollective service stop hangup
# during puppet agent startup for TORF-583117

. /etc/rc.d/init.d/functions

stop() {
    # Attempting a soft kill(TERM) if failed kill the process
    # immediately(KILL).This function is called on systemctl stop mcollective
    pkill -TERM mcollectived
    sleep 1 # grace period
    pgrep mcollectived && (pkill -KILL mcollectived)
}

case "$1" in
    stop)
        stop;
        ;;
    *)
        exit 2
        ;;
esac
exit $?
