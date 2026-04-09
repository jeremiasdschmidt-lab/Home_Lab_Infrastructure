#!/bin/bash
# Monitor Failed Login Attempts
# For Rocky Linux / RHEL the log is in /var/log/secure
LOG_FILE="/var/log/secure"

echo "--- Summary of Failed Login Attempts ---"
if [ -f $LOG_FILE ]; then
    grep "Failed password" $LOG_FILE | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr
else
    echo "Log file not found. Check permissions or path."
fi
