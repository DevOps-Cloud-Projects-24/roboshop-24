source common.sh

component=catalogue
NODEJS


dnf install mongodb-mongosh -y
STAT $?
mongosh --host mongo.dev.idevops24.online </app/db/master-data.js
STAT $?
