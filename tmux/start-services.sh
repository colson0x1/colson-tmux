#!/bin/zsh

# Check if a session name and commands file are passed
if [ $# -lt 2 ]; then
  echo "Usage: start_services <session_name> <commands_file>"
  exit 1
fi

SESSION_NAME=$1
COMMANDS_FILE=$2

# Check if the commands file exists
if [ ! -f "$COMMANDS_FILE" ]; then
  echo "Commands file not found: $COMMANDS_FILE"
  exit 1
fi

# Check if tmux session already exists
tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
  # Create a new tmux session and run the first command in the first window
  tmux new-session -d -s $SESSION_NAME -n "window-0"
  
  # Read the commands file and run each command in a new tmux window
  index=0
  while IFS= read -r line; do
    if [ $index -eq 0 ]; then
      # First command goes to the first window
      tmux send-keys -t "$SESSION_NAME:window-0" "$line" C-m
    else
      # Create a new window for each subsequent command
      tmux new-window -t $SESSION_NAME -n "window-$index"
      tmux send-keys -t "$SESSION_NAME:window-$index" "$line" C-m
    fi
    index=$((index+1))
  done < "$COMMANDS_FILE"

  # Optionally, attach to the session
  tmux attach-session -t $SESSION_NAME
else
  echo "Session $SESSION_NAME already exists. Attaching..."
  tmux attach -t $SESSION_NAME
fi
