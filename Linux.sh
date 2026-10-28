#!/bin/bash
# Student Number: S4228356
# Student Full Name: Jed Ernest John Beard
#
# Linux.sh - Updates the Linux computer with the latest security patches
# and keeps a log of every update operation in Linux.log.
# Schedule with root's crontab (sudo crontab -e) so it runs without a password prompt.

# Log file is stored in the same folder as this script (full path works under cron)
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
LOGFILE="$SCRIPT_DIR/Linux.log"

# Non-interactive mode stops apt from waiting for prompts when run by cron
export DEBIAN_FRONTEND=noninteractive

echo "===== Update started: $(date) =====" >> "$LOGFILE"

# Refresh the package list, then install all available updates/security patches
apt-get update -y >> "$LOGFILE" 2>&1
apt-get upgrade -y >> "$LOGFILE" 2>&1

echo "===== Update finished: $(date) =====" >> "$LOGFILE"
echo "" >> "$LOGFILE"
