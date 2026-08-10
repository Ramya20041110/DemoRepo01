#! /bin/bash

echo " ----------------------------------------------------"
echo " Server Health Montioring Using Shell Scripting "
echo " ----------------------------------------------------"
 
HOST_NAME = $(hostname)
DATE = $(date)
UPTIME = $(uptime)
CPU_USAGE = $(top -bn1 | grep "Cpu(s)")
MEMORY_USAGE = $(free -h)
DISK = $(df)
echo " HOST NAME : $HOST_NAME "
echo " CURRENT DATE : $DATE "
echo " UPTIME : $UPTIME "
echo " CPU USUAGE : $CPU_USAGE "
echo " MEMORY USUAGE : $MEMORY_USAGE "
echo " DISK MONITORING : $DISK "
if [ "$CPU_USAGE" -gt 70 ]; then
    echo "WARNING: CPU usage is above 70%"
else
    echo "CPU usage is normal"
fi

