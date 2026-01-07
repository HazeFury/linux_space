#!/bin/bash

ARCHITECTURE=$(uname -a)

PCPU=$(grep "physical id" /proc/cpuinfo | wc -l)

VCPU=$(grep "processor" /proc/cpuinfo | wc -l)

USED_RAM=$(free -m | grep "Mem" | awk '{print $3}')
TOTAL_RAM=$(free -m | grep "Mem" | awk '{print $2}')
RATIO_RAM=$(free -m | grep "Mem" | awk '{printf("%.2f", $3/$2*100)}')
MEM_USG="$USED_RAM/${TOTAL_RAM}MB ($RATIO_RAM%)"

DISK_USED=$(df -m | grep "/dev/" | grep -v "boot" | awk '{used += $3} END {print used}')
DISK_TOTAL=$(df -m | grep "/dev/" | grep -v "boot" | awk ' {total += $2} END {printf("%.1fGb") , total/1024}')
DISK_USAGE=$(df -m | grep "/dev/" | grep -v "boot" | awk '{used += $3} {total += $2} END {printf("(%d%%)") , used/total*100}')

wall "
	#Architecture : $ARCHITECTURE
	#CPU physical : $PCPU
	#vCPU : $VCPU
	#Memory Usage : $MEM_USG
	#Disk Usage : $DISK_USED/$DISK_TOTAL $DISK_USAGE
	"
