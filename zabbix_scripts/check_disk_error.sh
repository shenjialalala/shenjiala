#! /bin/bash
# author: jiangheng
# description: get error disk from dmesg

function get_error() {
    attach_num=`dmesg  -T  | grep -P  -w  ${1}[1]? |   awk '$9=/Attached/{print  NR}' | tail -1`
    if [[ ! -z $attach_num ]];then
        error_num=`dmesg  -T  | grep -P  -w  ${1}[1]? | awk  -v a=$attach_num 'NR>=a' \
                   | grep error  | grep  -e sector -e EXT4-fs | grep -v 'errors=remount-ro' | wc -l`
    else
        error_num=`dmesg  -T  |  grep -P  -w  ${1}[1]? \
                   | grep error  | grep  -e sector -e EXT4-fs | grep -v 'errors=remount-ro' | wc -l`
    fi

    if [[ $error_num -eq 0 ]];then
        return 0
    else
        return 1
    fi
}

dev_list=` df -hl   | fgrep /dev/ | awk '{print $1}' | cut -d '/' -f 3  |sed 's/[[:digit:]]*//g'`
error_disk_num=0
for i in `echo $dev_list`;do
    disk=`df -hl | grep $i  | awk '{print $NF}'`
    get_error $i
    #[[ $? -ne 0 ]] && echo "check_disk_error{disk=\"${disk}\",dev=\"$i\"} 1"
    [[ $? -ne 0 ]] && error_disk_num=$((eror_disk_num+1))
done

echo $error_disk_num

