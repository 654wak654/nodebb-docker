#!/bin/ash
set -e

mongo <<EOF
use admin

db.createUser({
    user: 'admin',
    pwd: '$MONGO_PASSWORD',
    roles: [
        {
            role: 'root',
            db: 'admin'
        }
    ]
})

use nodebb

db.createUser({
    user: 'nodebb',
    pwd: '$MONGO_PASSWORD',
    roles: [
        {
            role: 'readWrite',
            db: 'nodebb'
        },
        {
            role: 'clusterMonitor',
            db: 'admin'
        }
    ]
})
EOF
