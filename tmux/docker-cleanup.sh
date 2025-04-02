#!/bin/bash

# @ Docker weekly cleanup script

LOG_DIR="/var/log/docker-maintenance"
mkdir -p $LOG_DIR
LOG_FILE="$LOG_DIR/docker-cleanup-$(date +%Y-%m-%d).log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting weekly Docker cleanup" >> "$LOG_FILE"

# @ Log initial disk usage
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Initial disk usage:" >> "$LOG_FILE"
docker system df >> "$LOG_FILE"

# @ Perform system pruning
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Pruning Docker system..." >> "$LOG_FILE"
docker system prune -af >> "$LOG_FILE" 2>&1

# @ Clean builder cache
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Pruning builder cache..." >> "$LOG_FILE"
docker builder prune -af >> "$LOG_FILE" 2>&1

# @ Log final disk usage
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Final disk usage:" >> "$LOG_FILE"
docker system df >> "$LOG_FILE"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Cleanup completed" >> "$LOG_FILE"
echo "------------------------------------------" >> "$LOG_FILE"

# @ Clean old logs (keep 3 months)
find "$LOG_DIR" -name "docker-cleanup-*.log" -type f -mtime +90 -delete
