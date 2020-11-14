db.createUser({
    user: "admin",
    pwd: "1q2w3e4r",
    roles: [
        {
            role: "root",
            db: "admin"
        }
    ]
});

db = db.getSiblingDB("nodebb");

db.createUser({
    user: "nodebb",
    pwd: "1q2w3e4r",
    roles: [
        {
            role: "readWrite",
            db: "nodebb"
        },
        {
            role: "clusterMonitor",
            db: "admin"
        }
    ]
});
