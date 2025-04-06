#!/bin/bash

# ANSI color codes
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color
BOLD='\033[1m'
DIM='\033[2m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'

# Current date and user data
CURRENT_USER="colson0x1"
UTC_TIME="2025-04-06 05:40:07"

# Progress indication
echo -e "${BOLD}${BLUE}⏳ Initializing network scan...${NC}"
sleep 0.5
echo -e "${BOLD}${BLUE}⏳ Detecting network interfaces...${NC}"
sleep 0.5
echo -e "${BOLD}${BLUE}⏳ Fetching public IP addresses...${NC}"

# Get public IPs
PUBLIC_IPV4=$(curl -s -m 3 -4 ifconfig.me 2>/dev/null || echo "Not available")
PUBLIC_IPV6=$(curl -s -m 3 -6 ifconfig.me 2>/dev/null || echo "Not available")

# Get private IPs
ip_addresses=$(ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
main_ip=$(ip route get 1.1.1.1 2>/dev/null | grep -oP '(?<=src\s)\d+(\.\d+){3}')

# System info - with fallbacks for hostname
# Try multiple methods to get hostname
if command -v hostname >/dev/null 2>&1; then
    HOSTNAME=$(hostname)
elif [ -f /etc/hostname ]; then
    HOSTNAME=$(cat /etc/hostname)
elif [ -n "$HOSTNAME" ]; then
    # Use the environment variable if available
    HOSTNAME="$HOSTNAME"
else
    # Default if all else fails
    HOSTNAME="unknown-host"
fi

KERNEL=$(uname -r)

# Clear screen for better presentation
clear

# Set display width
DISPLAY_WIDTH=78

# Function to print centered text
center() {
    local text="$1"
    local color="$2"
    local width="${3:-$DISPLAY_WIDTH}"
    local padding=$(( (width - ${#text}) / 2 ))
    printf "%${padding}s" ""
    echo -e "${color}${text}${NC}"
}

# Function for section headers
section_header() {
    local text="$1"
    echo ""
    echo -e "${YELLOW}${BOLD}   ${text} ${NC}"
    echo -e "${DIM}   $(printf '%*s' "60" '' | tr ' ' '━')${NC}"
}

# Function for info items
info_item() {
    local icon="$1"
    local label="$2"
    local value="$3"
    local value_color="${4:-$WHITE}"
    
    printf "${PURPLE}   ${icon} %-12s${NC}" "${label}"
    echo -e "${value_color}${value}${NC}"
}

# Header with version and timestamp
echo ""
echo ""
center "🌐 NETWORK INFORMATION 🌐" "${BOLD}${CYAN}"
center "[ Developed by COLSON ]" "${GREEN}"
echo -e "${GRAY}   Build 2.1.4 • Last scan: $(date '+%H:%M:%S')${NC}"
echo ""

# System info section
section_header "⚙️  SYSTEM INFORMATION"
info_item "🖥️" "Hostname:" "${HOSTNAME}"
info_item "👤" "User:" "${CURRENT_USER}"
info_item "🐧" "Kernel:" "${KERNEL}"
info_item "🕒" "Date/Time:" "UTC - ${UTC_TIME}"

# Public IP section
section_header "🌎 PUBLIC IP ADDRESSES"
if [[ "$PUBLIC_IPV4" != "Not available" ]]; then
    info_item "📡" "IPv4:" "${PUBLIC_IPV4}" "${BOLD}${GREEN}"
else
    info_item "📡" "IPv4:" "Not available" "${BOLD}${RED}"
fi

if [[ "$PUBLIC_IPV6" != "Not available" ]]; then
    info_item "📡" "IPv6:" "${PUBLIC_IPV6}" "${BOLD}${GREEN}"
else
    info_item "📡" "IPv6:" "Not available" "${BOLD}${RED}"
fi

# Private IP section
section_header "🏠 PRIVATE IP ADDRESSES"

# Count interfaces
private_ip_count=$(echo "$ip_addresses" | wc -l)
echo -e "${GRAY}   Found ${private_ip_count} network interfaces${NC}"
echo ""

# Print private IPs with consistent formatting
while read -r ip; do
  if [[ "$ip" == "$main_ip" ]]; then
    printf "${BOLD}${GREEN}   ★ %-16s${NC}" "${ip}"
    echo -e "${PURPLE}Main Network Interface${NC}"
  elif [[ "$ip" == 127.0.0.1 ]]; then
    printf "${YELLOW}   • %-16s${NC}" "${ip}"
    echo -e "${PURPLE}Loopback${NC}"
  elif [[ "$ip" =~ ^172\.(1[6-9]|2[0-9]|3[0-1])\. ]]; then
    printf "${BLUE}   • %-16s${NC}" "${ip}"
    echo -e "${PURPLE}Docker${NC}"
  else
    printf "${BLUE}   • %-16s${NC}" "${ip}"
    echo -e "${GRAY}Other${NC}"
  fi
done <<< "$ip_addresses"

# Connectivity status
echo ""
echo -e "${DIM}   $(printf '%*s' "60" '' | tr ' ' '─')${NC}"
echo -e "${GRAY}   CONNECTIVITY STATUS${NC}"
echo ""

# Network status indicators with enhanced formatting
printf "${BOLD}   %-22s${NC}" "Local Network:"
echo -e "${BOLD}${GREEN}Connected${NC}"

printf "${BOLD}   %-22s${NC}" "Internet (IPv4):"
if [[ "$PUBLIC_IPV4" != "Not available" ]]; then
    echo -e "${BOLD}${GREEN}Connected${NC}"
else
    echo -e "${BOLD}${RED}Disconnected${NC}"
fi

printf "${BOLD}   %-22s${NC}" "Internet (IPv6):"
if [[ "$PUBLIC_IPV6" != "Not available" ]]; then
    echo -e "${BOLD}${GREEN}Connected${NC}"
else
    echo -e "${BOLD}${RED}Disconnected${NC}"
fi

echo ""
echo -e "${GRAY}   Use 'xip' or '1.1.1.1' command to run this tool again${NC}"
echo ""
