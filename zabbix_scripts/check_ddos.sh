#!/bin/bash
# author: longweijin
# date: 2013-05-30

result=`netstat -ntu | grep ^tcp \
    |awk '{print $5}' | cut -d: -f1 | grep -v 127.0.0.1 | sort | uniq -c | sort -nr \
    |awk  '{if($1>=200){ print $0}}'`

if [[ $result = '' ]]; then
    echo 'OK'
else
    echo $result
fi
