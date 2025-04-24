#!/bin/bash
source ./common.sh
check_root

dnf install nginx -y &>>$LOGFILE
validate $? "installing nginx"
systemctl enable nginx &>>$LOGFILE
validate $? "enabling nginx"
systemctl start nginx &>>$LOGFILE
validate $? "start nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
validate $? "remove default html code"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
validate $? "download the code "

cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$LOGFILE
validate $? "unzipping the code"

cp /home/ec2-user/expense-shell-2/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
systemctl restart nginx &>>$LOGFILE
validate $? "restart nginx"