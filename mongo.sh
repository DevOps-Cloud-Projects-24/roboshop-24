cp /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y
# update config file
systemctl enable mongod
systemctl start mongod
