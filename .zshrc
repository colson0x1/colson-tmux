# Vim alias for Nvim
alias vim='nvim'

# Enable Vim in Zsh
bindkey -v


# /* TMUX Aliases */
# Start tmux session
alias ts="tmux new-session -s"
# Attach to tmux session
alias ta="tmux attach-session -t"
# List tmux sessions
alias tl="tmux list-sessions"
# Kill tmux session
alias tk="tmux kill-session -t"
# Create a new window in the current tmux session
alias tnw="tmux new-window"
# Switch to the next tmux window
alias tn="tmux select-window -n"
# Switch to the previous tmux window
alias tp="tmux select-window -p"
# Split the tmux window horizontally
alias ths="tmux split-window -h"
# Split the tmux window vertically
alias tvs="tmux split-window -v"


# /* @ GIT Aliases */
# Show abbreviated Git status
alias gst="git status -sb"
# Show Git log in a more readable format
alias gl="git log --oneline --graph --decorate --all"
# Show a colorful and condensed Git log
alias glog="git log --graph --pretty=format:'%C(auto)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
# Show branches sorted by most recent commit
alias gbranches="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short) %(upstream:short) %09 %(committerdate:relative) %09 %(authorname)'"
# Show a diff of the changes in the working directory
alias gdiff="git diff"
# Show a side-by-side diff
alias gdiffs="git diff --side-by-side"
# Show a colored and word-diff of changes
alias gworddiff="git diff --color-words"
# Quickly stage all changes
alias gadd="git add --all"
# Commit with a message
alias gcommit="git commit -m"
# Amend the last commit
alias gamend="git commit --amend"
# Push the current branch to the remote
alias gpush="git push"
# Pull the latest changes from the remote
alias gpull="git pull"
# Fetch the latest changes from the remote
alias gfetch="git fetch"
# Show a colored and condensed view of git reflog
alias greflog="git reflog --pretty=format:'%C(auto)%h%Creset %C(auto)%gs%Creset %C(bold blue)<%an>%Creset %C(green)%gd%Creset %C(bold red)%gs%Creset %C(red)%cr%Creset'"
# Display the diff of a specific commit
alias gshow="git show"
# Create and checkout a new branch
alias gcb="git checkout -b"
# Switch to an existing branch
alias gco="git checkout"
# Delete a local branch
alias gbd="git branch -d"
# Delete a remote branch
alias gbrd="git push origin --delete"
# Rename a branch
alias gmv="git branch -m"
# Interactive rebase
alias grebase="git rebase -i"
# Reset the working directory and staging area to HEAD
alias grhead="git reset --hard HEAD"
# Reset the working directory and staging area to a specific commit hash
alias grhash="git reset --hard"
# Push changes to the remote repository (assuming the branch is 'main')
alias gpushmain="git push origin main"

# Create a new React app using Create React App
alias cra ="npx create-react-app"
