# @ COLSON ZSH configurations for packages/softwares

export PATH="$HOME/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# path to Golang
# export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# export GOPATH=$HOME/golang
# export GOROOT=/usr/local/opt/go/libexec
# export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:$GOROOT/bin

# Load Angular CLI autocompletion.
# source <(ng completion script)
eval "$(ng completion script)"
export PATH=$PATH:/Users/colson/.spicetify

# bun completions
[ -s "/Users/colson/.bun/_bun" ] && source "/Users/colson/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# @ COLSON personalized alias for Software Development Productivity 

# NVIM alias for vim
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
alias ths="tmux split-window -h"chage bash to zsh
# Split the tmux window vertically
alias tvs="tmux split-window -v"
# Rename tmux session
alias tr="tmux rename-session -t"


# /* @ GIT Aliases */
# GIT Aliases
# Normal Git Status
alias gst="git status"
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
# alias gds="git diff --side-by-side"
alias gds="git difftool --tool=vimdiff"
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
alias gplm="git pull origin main"
# Fetch the latest changes from the remote
alias gf="git fetch"
alias gfm="git fetch origin main"
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
# See detail information such as local or remote branch in use
alias gbs="git branch -vva"

# @ Git Alias Shortcuts for Monorepo Workflow

# Check the status of all submodules
alias gsms='g submodule foreach g status'
alias gsmst='g submodule foreach g status'
# Usage: gsms or gsmst
# This will check the status of all submodules in the repository.

# Stage all changes, including submodules
alias gasm='g add -A && g submodule foreach g add -A'
# Usage: gasm
# This will stage all changes in the main repo and in all submodules.

# Commit with a message
alias gsc='g commit -m'
# Usage: gsc "Your commit message"
# This will commit the staged changes with the specified message.

# Show all staged files, including submodules
alias gstg='g diff --cached && g submodule foreach g diff --cached'
# Usage: gstg
# This will display the differences of all staged files, including submodules.

# Check for untracked files, including submodules
alias gunt='g ls-files --others --exclude-standard && g submodule foreach g ls-files --others --exclude-standard'
# Usage: gunt
# This will show all untracked files in the main repo and submodules.

# Force add and commit all changes, including submodules
alias gsf='g add -A && g commit -am "Auto commit changes" && g submodule foreach "g add -A && g commit -am Auto commit submodule changes"'
# Usage: gsf
# This will force add and commit all changes with a predefined message for both the main repo and all submodules.


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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/colson/google-cloud-sdk/path.zsh.inc' ]; then . '/home/colson/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/colson/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/colson/google-cloud-sdk/completion.zsh.inc'; fi

# NVIM 
alias nv="nvim ."
# NVIM in Sudo mode
alias nvv="sudo nvim ."
# Clear terminal
alias cl="clear"

# Start tmux session if none exists
if [ -z "$TMUX" ] && [ -z "$TMUX_SESSION" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi

alias ss="start-services"
