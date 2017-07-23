#!/bin/bash
#auditor:sunweifeng
#date:2015-03-11
m=`mpstat -P ALL | sed '1,4 d' | awk '{print $NF}' | sort -V | head -n1`
echo $m
