#!/bin/bash

echo " ----------------------------------------------------"
echo " Server Health Monitoring Using Shell Scripting "
echo " ----------------------------------------------------"

HOST_NAME=$(hostname)
DATE=$(date)
UPTIME=$(uptime)
CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')
MEMORY_USAGE=$(free -h)
DISK=$(df -h)

echo " HOST NAME      : $HOST_NAME "
echo " CURRENT DATE   : $DATE "
echo " UPTIME         : $UPTIME "
echo " CPU USAGE      : $CPU_USAGE% "
echo " MEMORY USAGE   :"
echo "$MEMORY_USAGE"
echo " DISK MONITORING:"
echo "$DISK"

if [ "$CPU_USAGE" -gt 70 ]; then
    echo "WARNING: CPU usage is above 70%"
else
    echo "CPU usage is normal "
fi

