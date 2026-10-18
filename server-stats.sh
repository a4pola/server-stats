#!/bin/bash

echo "========================================="
echo "       ОТЧЕТ ОРГАНИЗАЦИИ МОНИТОРИНГА     "
echo "       Дата: $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================="

echo -e "\n[1] ИСПОЛЬЗОВАНИЕ ПРОЦЕССОРА (CPU)"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "  Общая загрузка CPU: ${CPU_USAGE}%"

echo -e "\n[2] ИСПОЛЬЗОВАНИЕ ПАМЯТИ (RAM)"
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_PCT=$(awk -v used="$MEM_USED" -v total="$MEM_TOTAL" 'BEGIN {printf "%.2f", (used/total)*100}')

echo "  Всего памяти:     ${MEM_TOTAL} MB"
echo "  Использовано:     ${MEM_USED} MB (${MEM_PCT}%)"
echo "  Свободно (Free):  ${MEM_FREE} MB"

echo -e "\n[3] ИСПОЛЬЗОВАНИЕ ДИСКА (Раздел /)"
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
DISK_PCT=$(df -h / | awk 'NR==2 {print $5}')

echo "  Всего места:      ${DISK_TOTAL}"
echo "  Использовано:     ${DISK_USED} (${DISK_PCT})"
echo "  Свободно:         ${DISK_FREE}"

echo -e "\n[4] ТОП-5 ПРОЦЕССОВ ПО CPU"
echo "  %CPU   PID    КОМАНДА"
ps -eo pcpu,pid,comm --sort=-pcpu | head -n 6 | sed 's/^/  /'

echo -e "\n[5] ТОП-5 ПРОЦЕССОВ ПО ПАМЯТИ (RAM)"
echo "  %MEM   PID    КОМАНДА"
ps -eo pmem,pid,comm --sort=-pmem | head -n 6 | sed 's/^/  /'

echo -e "\n========================================="
