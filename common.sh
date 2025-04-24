USER=$(id -u)
TIME_STAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/${SCRIPT_NAME}-${TIME_STAMP}.log
check_root(){
    if [ $USER -ne 0 ]
    then 
        echo "you should make root user"
        exit 1
    else
        echo "you are super user"
    fi

}

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

validate(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2  $R..FAILURE $N"
        exit 1
    else 
        echo -e "$2  ..$G SUCCESS $N"
    fi
}