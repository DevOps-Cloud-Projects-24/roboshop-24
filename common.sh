log_file=/tmp/roboshop.log
rm -f $log_file
PRINT(){
  echo &>>$log_file
  echo &>>$log_file
  echo "######################## *$ ##################" &>>$log_file
  echo $*
}

NODEJS(){
PRINT disable node nodejs # This is how you can able to print only the optional output
dnf module disable nodejs -y &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

PRINT enable nodejs
dnf module enable nodejs:20 -y &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

PRINT install nodejs
dnf install nodejs -y &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

PRINT copy service file
cp ${component}.service /etc/systemd/system/${component}.service &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

PRINT copy mongo file
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

PRINT adding user
useradd roboshop &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

PRINT removing app directory
rm -rf /app &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

 PRINT Making new directory
mkdir /app &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

PRINT downloading the zip file
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$log_file
cd /app
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

PRINT Unzipping the file
unzip /tmp/${component}.zip &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

cd /app
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

PRINT Installing packages
npm install &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

PRINT reloading
systemctl daemon-reload &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

PRINT enabling the server
systemctl enable ${component} &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

PRINT restarting the server
systemctl restart ${component} &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi
}
