#!/usr/bin/env bash
#
# A simple script to identify top IP addresses with failed SSH login attempts.
# Works on systems that log authentication messages to /var/log/auth.log.
# Adjust paths and parsing logic if your distro uses a different log format.

LOGFILE="/var/log/auth.log"

# Check if log file exists
if [ ! -f "$LOGFILE" ]; then
  echo "Error: Log file $LOGFILE not found."
  exit 1
fi

echo "=== Top 5 IP Addresses with Failed SSH Attempts ==="
grep "Failed password" "$LOGFILE" \
  | awk '{print $(NF-3)}' \
  | sort \
  | uniq -c \
  | sort -nr \
  | head -5


# Make the script executable: chmod +x ssh_fail_monitor.sh
# Run the script: ./ssh_fail_monitor.sh