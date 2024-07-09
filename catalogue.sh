source common.sh

component=catalogue
NODEJS


dnf install mongodb-mongosh -y
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi
mongosh --host mongo.dev.idevops24.online </app/db/master-data.js
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi
