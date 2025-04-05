#!/bin/bash

# TYPEMUSE GitOps Orchestration Engine
# Engineer: COLSON

# @ Terminal colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# @ Detect GitHub username
GITHUB_USERNAME=$(git config user.name 2>/dev/null || echo $(whoami))
GIT_EMAIL=$(git config user.email 2>/dev/null || echo "")
SYSTEM_USER=$(whoami)

# @ Log
echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║       TYPEMUSE GITOPS ORCHESTRATION ENGINE     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo -e "${YELLOW}Operator: ${GITHUB_USERNAME} (@${SYSTEM_USER})${NC}"
echo -e "${YELLOW}Timestamp: $(date '+%Y-%m-%d %H:%M:%S') UTC${NC}"

# @ If git email is available, show it
if [ ! -z "$GIT_EMAIL" ]; then
    echo -e "${YELLOW}Git Email: ${GIT_EMAIL}${NC}"
fi

# @ Get current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo -e "${CYAN}Current branch: ${current_branch}${NC}"

# @ Update main branch
echo -e "\n${BLUE}[1/3]${NC} Updating main branch..."
git checkout main && git pull
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to update main branch. Aborting.${NC}"
    git checkout $current_branch
    exit 1
fi
echo -e "${GREEN}Main branch updated successfully.${NC}"

# @ Determine which branches to rebase
if [ $# -eq 0 ]; then
    echo -e "\n${BLUE}[2/3]${NC} No branches specified. Finding feature branches..."
    # Find all branches except main
    branches=$(git for-each-ref --format='%(refname:short)' refs/heads/ | grep -v '^main$')
    
    # Check if any branches were found
    if [ -z "$branches" ]; then
        echo -e "${YELLOW}No feature branches found. Only 'main' branch exists.${NC}"
        echo -e "${RED}Nothing to reconcile. Exiting.${NC}"
        exit 0
    fi
    
    # Allow user to select specific branches
    echo -e "${YELLOW}Found the following branches:${NC}"
    select_branches=()
    i=1
    for branch in $branches; do
        echo -e "${YELLOW}$i)${NC} $branch"
        select_branches+=("$branch")
        ((i++))
    done
    
    echo -e "${YELLOW}Enter branch numbers to reconcile (space-separated), or 'all' for all branches:${NC}"
    read -r selection
    
    if [[ "$selection" == "all" ]]; then
        final_branches=("${select_branches[@]}")
    else
        final_branches=()
        for num in $selection; do
            if [[ $num =~ ^[0-9]+$ ]] && [ $num -ge 1 ] && [ $num -le ${#select_branches[@]} ]; then
                final_branches+=("${select_branches[$num-1]}")
            fi
        done
    fi
else
    # Use branches specified on command line
    final_branches=("$@")
fi

if [ ${#final_branches[@]} -eq 0 ]; then
    echo -e "${RED}No valid branches selected. Exiting.${NC}"
    git checkout $current_branch
    exit 1
fi

# @ Rebase each branch
echo -e "\n${BLUE}[3/3]${NC} Reconciling selected branches with main..."
success_branches=()
failed_branches=()

for branch in "${final_branches[@]}"; do
    echo -e "\n${YELLOW}Processing: ${branch}${NC}"
    if git checkout "$branch"; then
        if git rebase main; then
            echo -e "${GREEN}✅ Successfully reconciled $branch with main${NC}"
            success_branches+=("$branch")
        else
            echo -e "${RED}❌ Failed to reconcile $branch. Aborting this branch's integration.${NC}"
            git rebase --abort
            failed_branches+=("$branch")
        fi
    else
        echo -e "${RED}❌ Failed to checkout $branch. Skipping.${NC}"
        failed_branches+=("$branch")
    fi
done

# @ Generate summary
echo -e "\n${BLUE}══════════════ INTEGRATION SUMMARY ══════════════${NC}"
echo -e "${GREEN}Successfully reconciled (${#success_branches[@]}):${NC}"
for branch in "${success_branches[@]}"; do
    echo -e "${GREEN}  ✓ $branch${NC}"
done

if [ ${#failed_branches[@]} -gt 0 ]; then
    echo -e "\n${RED}Failed to reconcile (${#failed_branches[@]}):${NC}"
    for branch in "${failed_branches[@]}"; do
        echo -e "${RED}  ✗ $branch${NC}"
    done
fi

# @ Return to original branch
echo -e "\n${BLUE}Returning to original branch: $current_branch${NC}"
git checkout $current_branch

echo -e "\n${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║         ORCHESTRATION CYCLE COMPLETED          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"

# # @ v1
# #!/bin/bash
#
# # TYPEMUSE GitOps Orchestration Engine
# # Engineer: COLSON
#
# # @ Terminal colors
# GREEN='\033[0;32m'
# RED='\033[0;31m'
# BLUE='\033[0;34m'
# YELLOW='\033[0;33m'
# CYAN='\033[0;36m'
# NC='\033[0m' # No Color
#
# # @ Detect GitHub username
# GITHUB_USERNAME=$(git config user.name 2>/dev/null || echo $(whoami))
# GIT_EMAIL=$(git config user.email 2>/dev/null || echo "")
# SYSTEM_USER=$(whoami)
#
# # @ Log
# echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
# echo -e "${BLUE}║       TYPEMUSE GITOPS ORCHESTRATION ENGINE     ║${NC}"
# echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
# echo -e "${YELLOW}Operator: ${GITHUB_USERNAME} (@${SYSTEM_USER})${NC}"
# echo -e "${YELLOW}Timestamp: $(date '+%Y-%m-%d %H:%M:%S') UTC${NC}"
#
# # @ If git email is available, show it
# if [ ! -z "$GIT_EMAIL" ]; then
#     echo -e "${YELLOW}Git Email: ${GIT_EMAIL}${NC}"
# fi
#
# # @ Get current branch
# current_branch=$(git rev-parse --abbrev-ref HEAD)
# echo -e "${CYAN}Current branch: ${current_branch}${NC}"
#
# # @ Update main branch
# echo -e "\n${BLUE}[1/3]${NC} Updating main branch..."
# git checkout main && git pull
# if [ $? -ne 0 ]; then
#     echo -e "${RED}Failed to update main branch. Aborting.${NC}"
#     git checkout $current_branch
#     exit 1
# fi
# echo -e "${GREEN}Main branch updated successfully.${NC}"
#
# # @ Determine which branches to rebase
# if [ $# -eq 0 ]; then
#     echo -e "\n${BLUE}[2/3]${NC} No branches specified. Finding feature branches..."
#     # Find all branches except main
#     branches=$(git for-each-ref --format='%(refname:short)' refs/heads/ | grep -v '^main$')
#     
#     # Allow user to select specific branches
#     echo -e "${YELLOW}Found the following branches:${NC}"
#     select_branches=()
#     i=1
#     for branch in $branches; do
#         echo -e "${YELLOW}$i)${NC} $branch"
#         select_branches+=("$branch")
#         ((i++))
#     done
#     
#     echo -e "${YELLOW}Enter branch numbers to reconcile (space-separated), or 'all' for all branches:${NC}"
#     read -r selection
#     
#     if [[ "$selection" == "all" ]]; then
#         final_branches=("${select_branches[@]}")
#     else
#         final_branches=()
#         for num in $selection; do
#             if [[ $num =~ ^[0-9]+$ ]] && [ $num -ge 1 ] && [ $num -le ${#select_branches[@]} ]; then
#                 final_branches+=("${select_branches[$num-1]}")
#             fi
#         done
#     fi
# else
#     # Use branches specified on command line
#     final_branches=("$@")
# fi
#
# if [ ${#final_branches[@]} -eq 0 ]; then
#     echo -e "${RED}No valid branches selected. Exiting.${NC}"
#     git checkout $current_branch
#     exit 1
# fi
#
# # @ Rebase each branch
# echo -e "\n${BLUE}[3/3]${NC} Reconciling selected branches with main..."
# success_branches=()
# failed_branches=()
#
# for branch in "${final_branches[@]}"; do
#     echo -e "\n${YELLOW}Processing: ${branch}${NC}"
#     if git checkout "$branch"; then
#         if git rebase main; then
#             echo -e "${GREEN}✅ Successfully reconciled $branch with main${NC}"
#             success_branches+=("$branch")
#         else
#             echo -e "${RED}❌ Failed to reconcile $branch. Aborting this branch's integration.${NC}"
#             git rebase --abort
#             failed_branches+=("$branch")
#         fi
#     else
#         echo -e "${RED}❌ Failed to checkout $branch. Skipping.${NC}"
#         failed_branches+=("$branch")
#     fi
# done
#
# # @ Generate summary
# echo -e "\n${BLUE}══════════════ INTEGRATION SUMMARY ══════════════${NC}"
# echo -e "${GREEN}Successfully reconciled (${#success_branches[@]}):${NC}"
# for branch in "${success_branches[@]}"; do
#     echo -e "${GREEN}  ✓ $branch${NC}"
# done
#
# if [ ${#failed_branches[@]} -gt 0 ]; then
#     echo -e "\n${RED}Failed to reconcile (${#failed_branches[@]}):${NC}"
#     for branch in "${failed_branches[@]}"; do
#         echo -e "${RED}  ✗ $branch${NC}"
#     done
# fi
#
# # @ Return to original branch
# echo -e "\n${BLUE}Returning to original branch: $current_branch${NC}"
# git checkout $current_branch
#
# echo -e "\n${BLUE}╔════════════════════════════════════════════════╗${NC}"
# echo -e "${BLUE}║         ORCHESTRATION CYCLE COMPLETED          ║${NC}"
# echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
