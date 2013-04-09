#!/bin/bash
#
# Anime Lineup Server startup script
#
# chkconfig:    345 80 20
# description:  Anime Lineup Server
# processname:  anime_lineup_server

# Source function library.
. /etc/rc.d/init.d/functions

lock=/var/lock/subsys/anime_lineup

start() {
  su - web -c 'cd ~/anime_lineup; unicorn_rails -c config/unicorn.rb -E production -D'
}

stop() {
  su - web -c 'kill -INT $(cat ~/anime_lineup/tmp/pids/unicorn.pid)'
}

restart() {
  stop
  start
}

case "$1" in
  start)
    start
    touch ${lock}
    ;;
  stop)
    stop
    rm -rf ${lock}
    ;;
  restart)
    restart
    touch ${lock}
    ;;
  *)
    echo $"Usage: $0 {start|stop|restart}"
    exit 2
esac
