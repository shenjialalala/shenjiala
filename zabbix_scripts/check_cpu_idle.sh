#!/bin/bash
#2017-06-17
#jiangheng
sar -P ALL 1 10 | grep Average | sed -n '3p'  | awk '{print $NF}'
