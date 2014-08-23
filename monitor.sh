#!/bin/bash

set -x

DATE=`date "+%Y-%m-%dT%H:%M:%S"`
CPU_TEMP=`cat /sys/class/thermal/thermal_zone0/temp`
CPU_TEMP=`echo "$CPU_TEMP" | awk '{printf "%f", $1 /1000}'`
CPU_USAGE=`top c n 1 b | awk '/Cpu\(s\):/ {print $2}'`
GPU_TEMP=`/opt/vc/bin/vcgencmd measure_temp | sed 's/^.*=//' | sed 's/.C//'`
MEM_USED=`free | awk '/Mem:/ {print $3}'`
MEM_TOTAL=`free | awk '/Mem:/ {print $2}'`
MEM_USAGE=`echo "$MEM_USED $MEM_TOTAL" | awk '{printf "%f", $1 / $2 * 100}'`

function makeJsonData(){
  VALUE=$1
  echo "{\"timestamp\":\"$DATE\",\"value\":$VALUE}" > DATA_JSON
}

makeJsonData $CPU_TEMP
cat DATA_JSON
curl --request POST --data-binary @DATA_JSON --header "U-ApiKey:28c97668105f6211667d35a4d1cecefe" http://api.yeelink.net/v1.0/device/13595/sensor/22517/datapoints

makeJsonData $CPU_USAGE
cat DATA_JSON
curl --request POST --data-binary @DATA_JSON --header "U-ApiKey:28c97668105f6211667d35a4d1cecefe" http://api.yeelink.net/v1.1/device/13595/sensor/22579/datapoints

makeJsonData $GPU_TEMP
cat DATA_JSON
curl --request POST --data-binary @DATA_JSON --header "U-ApiKey:28c97668105f6211667d35a4d1cecefe" http://api.yeelink.net/v1.1/device/13595/sensor/22580/datapoints

makeJsonData $MEM_USAGE
cat DATA_JSON
curl --request POST --data-binary @DATA_JSON --header "U-ApiKey:28c97668105f6211667d35a4d1cecefe" http://api.yeelink.net/v1.1/device/13595/sensor/22581/datapoints


curl --request GET --header "U-ApiKey:28c97668105f6211667d35a4d1cecefe" http://api.yeelink.net/v1.1/device/13595/sensor/22512/datapoints > switch

VALUE=`cat switch | sed 's/^.*value\"://g' | sed 's/,.*$//'`

echo $VALUE

if [ $VALUE = 1 ]; then

        echo "camming"

        for i in $(seq 1 5)
        do

wget -O a.jpeg "http://192.168.11.99:8080/?action=snapshot"
curl --request POST --data-binary @"./a.jpeg"  --header "U-ApiKey:28c97668105f6211667d35a4d1cecefe" http://api.yeelink.net/v1.0/device/13595/sensor/22505/photos

                sleep 11
        done

fi
