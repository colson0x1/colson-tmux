# Nvim alias for vim
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
# GIT Aliases
# Abbreviated Git status
alias gs="git status -sb"
# Readable Git log
alias gl="git log --oneline --graph --decorate --all"
# Colorful and condensed Git log
alias gg="git log --graph --pretty=format:'%C(auto)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
# Branches sorted by most recent commit
alias gb="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short) %(upstream:short) %09 %(committerdate:relative) %09 %(authorname)'"
# Diff of changes in the working directory
alias gd="git diff"
# Side-by-side diff
alias gds="git diff --side-by-side"
# Colored and word-diff of changes
alias gwd="git diff --color-words"
# Quickly stage all changes
alias ga="git add --all"
# Commit with a message
alias gc="git commit -m"
# Amend the last commit
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"
alias gcam="git commit --amend -m"
# Push the current branch to the remote
alias gp="git push"
# Pull the latest changes from the remote
alias gpl="git pull"
# Fetch the latest changes from the remote
alias gf="git fetch"
# Colored and condensed git reflog
alias grl="git reflog --pretty=format:'%C(auto)%h%Creset %C(auto)%gs%Creset %C(bold blue)<%an>%Creset %C(green)%gd%Creset %C(bold red)%gs%Creset %C(red)%cr%Creset'"
# Diff of a specific commit
alias gsow="git show"
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
alias gri="git rebase -i"
# Alias for branch checkout
alias gch="git checkout"
# Push changes to the remote repository (assuming the branch is 'main')
alias gpm="git push origin main"
# Add specific file
alias gaf="git add"
# Reset the current branch to the latest commit in the remote repository
alias grh="git reset --hard HEAD"
# Reset the current branch to the commit before the latest commit in the remote repository
alias grh1="git reset --hard HEAD~1"
# Push the local changes forcefully to the 'main' branch in the remote repository
alias gpmf='git push origin main --force'


# Create a new React app using Create React App
alias cra="npx create-react-app"
# Create a new React app using VITE 
alias cva="npm create vite@latest"
# Create a new NEXT app
alias cna="npx create-next-app@latest"

# /* Zsh and Tmux Reload */
# Reload Zsh configuration
alias zshrl="source ~/.zshrc"
# Reload Tmux configuration
alias tmuxrl="tmux source ~/.config/tmux/tmux.conf"

# Docker aliases
alias d="docker"
alias dps="docker ps"
alias di="docker images"
alias db="docker build -t"
alias dr="docker run -it --rm"
alias dex="docker exec -it"
alias dst="docker stop"
alias drm="docker rm"
alias drmi="docker rmi"

# Kubernetes aliases
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kga="kubectl get all"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kaf="kubectl apply -f"
alias kl="kubectl logs"
alias ke="kubectl exec -it"

# Function for switching namespaces
# $ kns development
# $ kubectl get pods  # Now we're working in the development namespace
# $ kns production
# $ kubectl get pods  # Now we're working in the production namespace
kns() {
  kubectl config set-context --current --namespace="$1"
}
