#!/bin/ash

shutdown() {
    echo 'Shutting down.'
    ./nodebb stop
    [ -e /etc/nodebb/config.json ] || cp /opt/nodebb/config.json /etc/nodebb/config.json
    echo 'Stopped'
    exit 143;
}

term_handler() {
    echo 'SIGTERM received'
    shutdown
}

trap term_handler SIGTERM

[ -e /etc/nodebb/config.json ] && rm -f /opt/nodebb/config.json && ln -s /etc/nodebb/config.json /opt/nodebb/config.json
cd /opt/nodebb/
# Uncomment the line below to get updates on every start
# NOT recommended without setting up backups
# [ -e /etc/nodebb/config.json ] && yes n | ./nodebb upgrade
node app.js & wait ${!}
echo 'NodeBB died'
shutdown
