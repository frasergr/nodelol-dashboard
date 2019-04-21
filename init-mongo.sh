mongo -u $MONGO_INITDB_ROOT_USERNAME -p $MONGO_INITDB_ROOT_PASSWORD <<EOF
db.getSiblingDB('$MONGO_DB_PROD').createUser({
  user: '$MONGO_DB_USER_PROD',
  pwd: '$MONGO_DB_PASSWORD_PROD',
  roles: ["readWrite", "dbAdmin"]
})
db.getSiblingDB('$MONGO_DB_DEV').createUser({
  user: '$MONGO_DB_USER_DEV',
  pwd: '$MONGO_DB_PASSWORD_DEV',
  roles: ["readWrite", "dbAdmin"]
})
EOF
