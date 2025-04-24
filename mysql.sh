#!/bin/bash

read  -s -p "enter db password:" DB_PASSWORD 
check_root

dnf install mysql-server -y &>>$LOGFILE
validate $? "installing mysql"

systemctl start mysqld &>>$LOGFILE
validate $? "starting mysql"


mysql -h db.sundardev.online -uroot -p${DB_PASSWORD} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then 
    mysql_secure_installation --set-root-pass ${DB_PASSWORD} &>>$LOGFILE
    validate $? "setting root password"
else
    echo -e "setting root password already done:$Y SKIPPING $N"
fi