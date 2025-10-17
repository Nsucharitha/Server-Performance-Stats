#!/usr/bin/env bash

echo "Server Stats"
echo "============"

# ------------------ CPU USAGE ------------------
echo "CPU Usage:"
# 'top -bn1' runs top in batch mode once (no live screen)
# grep filters the CPU line, and awk prints 100 - idle% = used%
top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8 "% used"}'

# ------------------ MEMORY USAGE ------------------
echo
echo "Memory Usage:"
# 'free -h' shows human-readable memory stats.
# We use awk to pick the 'Mem:' line and show used/free columns.
free -h | awk '/Mem:/ {print "Used:", $3, "Free:", $4, "(" $3 "/" $2 ")"}'

# ------------------ DISK USAGE ------------------
echo
echo "Disk Usage:"
# 'df -h --total' shows disk usage summary.
# grep 'total' filters the last line which sums all filesystems.
df -h --total | grep total | awk '{print "Used:", $3, "Free:", $4, "(", $5, "used)"}'

# ------------------ TOP 5 PROCESSES BY CPU ------------------
echo
echo "Top 5 Processes by CPU:"
# ps lists all processes (-e)
# -o specifies which columns to show (pid, command name, %cpu, %mem)
# --sort=-%cpu sorts in descending order by CPU usage
# head -n 6 shows the header plus top 5
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

# ------------------ TOP 5 PROCESSES BY MEMORY ------------------
echo
echo "Top 5 Processes by Memory:"
ps -eo pid,comm,%mem,%cpu --sort=-%mem | head -n 6
