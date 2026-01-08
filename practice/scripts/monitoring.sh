#!/bin/bash

ARCHITECTURE=$(uname -a)

PCPU=$(grep "physical id" /proc/cpuinfo | wc -l)

VCPU=$(grep "processor" /proc/cpuinfo | wc -l)

USED_RAM=$(free -m | grep "Mem" | awk '{print $3}')
TOTAL_RAM=$(free -m | grep "Mem" | awk '{print $2}')
RATIO_RAM=$(free -m | grep "Mem" | awk '{printf("%.2f", $3/$2*100)}')
MEM_USG="$USED_RAM/${TOTAL_RAM}MB ($RATIO_RAM%)"

DISK_USED=$(df -m | grep "/dev/" | grep -v "boot" | awk '{used += $3} END {print used}')
DISK_TOTAL=$(df -m | grep "/dev/" | grep -v "boot" | awk ' {total += $2} END {printf("%dGb") , total/1024}')
DISK_USAGE=$(df -m | grep "/dev/" | grep -v "boot" | awk '{used += $3} {total += $2} END {printf("(%d%%)") , used/total*100}')

CPU_LOAD=$(vmstat 1 2 | tail -1 | awk '{printf("%.1f%%", 100-$15)}')

LAST_BOOT=$(who -b | awk '{print $3 " " $4}')

LVM_STATUS=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes ; else echo no; fi)

TCP=$(ss -ta | grep "ESTAB" | wc -l)

USER_LOG=$(users | wc -w | awk '{printf("%d\n", $1-2)}')

MAC_ADDRESS=$(ip link | grep "link/ether" | awk '{print $2}')
IP_ADDRESS=$(hostname -I | awk '{print $1}')

wall "
	#Architecture : $ARCHITECTURE
	#CPU physical : $PCPU
	#vCPU : $VCPU
	#Memory Usage : $MEM_USG
	#Disk Usage : $DISK_USED/$DISK_TOTAL $DISK_USAGE
	#CPU load : $CPU_LOAD
	#Last boot : $LAST_BOOT
	#LVM use : $LVM_STATUS
	#Connections TCP : $TCP ESTABLISHED
	#User log : $USER_LOG
	#Network : IP $IP_ADDRESS ($MAC_ADDRESS)
	"
