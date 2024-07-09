log_file=/tmp/roboshop.log
rm -f $log_file
PRINT(){
  echo &>>$log_file
  echo &>>$log_file
  echo "######################## *$ ##################" &>>$log_file
  echo $*
}
NODEJS(){
PRINT disable node nodejs
dnf module disable nodejs -y &>>$log_file

PRINT enable nodejs
dnf module enable nodejs:20 -y &>>$log_file

PRINT install nodejs
dnf install nodejs -y &>>$log_file

PRINT copy service file
cp ${component}.service /etc/systemd/system/${component}.service &>>$log_file

PRINT copy mongo file
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file

PRINT adding user
useradd roboshop &>>$log_file

PRINT removing app directory
rm -rf /app &>>$log_file

 PRINT Making new directory
mkdir /app &>>$log_file

PRINT downloading the zip file
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$log_file
cd /app

PRINT Unzipping the file
unzip /tmp/${component}.zip &>>$log_file

cd /app

PRINT Installing packages
npm install &>>$log_file

PRINT reloading
systemctl daemon-reload &>>$log_file

PRINT enabling the server
systemctl enable ${component} &>>$log_file

PRINT restarting the server
systemctl restart ${component} &>>$log_file
}
