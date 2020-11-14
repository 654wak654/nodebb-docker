#!/bin/sh

shutdown() {
    echo "Shutting down."
    node nodebb stop
    [ -e /etc/nodebb/config.json ] || cp /opt/nodebb/config.json /etc/nodebb/config.json
    echo "Stopped"
    exit 143;
}

term_handler() {
    echo "SIGTERM received"
    shutdown
}

trap term_handler SIGTERM

[ -e /etc/nodebb/config.json ] && rm -f /opt/nodebb/config.json && ln -s /etc/nodebb/config.json /opt/nodebb/config.json
cd /opt/nodebb/
[ -e /etc/nodebb/config.json ] && yes n | node nodebb upgrade
node app.js & wait ${!}
echo "NodeBB died"
shutdown
