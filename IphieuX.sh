  [1/1]                                                                                                                                                                                                                                                                                                                                                                                                                                                                         IphieuX.sh                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  #!/bin/bash

# ASCII Art for IPHIE v3.5
echo -e "\e[1;36m"
cat << "EOF"
  ___  ____  _   _   ___   ___ ___   _   _            __  __
 |_ _||  _ || |_| | |   | | |_/__/  /_\ | |  x   \/   \ \/ /         by
  | | | |__||  _| |  | |  |  __     | | | |      /\    \/ /            ephraim sibale
  | | | |   | | | |  | |  | |__   _ | |_| }            / / \           contact:ephraimsibale20@gmail.com
 |___||_|   |_| |_| |___| |_|__| |_| \___/    💀      /_/ \_\💀💀💀💀..........
EOF
echo -e "\e[0m"
echo -e "\e[1;34mWelcome to IPHIEuX v3.5 - Advanced IP hacking Information Tool\e[0m"
echo -e "\e[1;34m------for-------educational------purposes---------only---💀💀---\e[0m"
echo ""

# Check if running as root
checkroot() {
    if [[ "$(id -u)" -ne 0 ]]; then
        printf "\e[1;77m 🛡️ Please, run this program as root!\n\e[0m"
        exit 1
    fi
}

# Call the checkroot function to ensure the script is run as root
checkroot

# Function to get IP information using ipinfo.io API
get_ip_info() {
    local ip_address=$1

    # Make API request
    response=$(curl -s "https://ipinfo.io/$ip_address/json")

    # Parse and display IP information
    echo -e "\e[1;32mIP Information:\e[0m"
    echo -e "\e[1;32m---------------\e[0m"
    echo -e "\e[1;33mIP Address:\e[0m $(echo "$response" | jq -r '.ip')"
    echo -e "\e[1;33mCity:\e[0m $(echo "$response" | jq -r '.city')"
    echo -e "\e[1;33mRegion:\e[0m $(echo "$response" | jq -r '.region')"
    echo -e "\e[1;33mCountry:\e[0m $(echo "$response" | jq -r '.country')"
    echo -e "\e[1;33mISP:\e[0m $(echo "$response" | jq -r '.org')"
    echo -e "\e[1;33mLocation:\e[0m $(echo "$response" | jq -r '.loc')"
    echo -e "\e[1;33mPostal Code:\e[0m $(echo "$response" | jq -r '.postal')"
    echo -e "\e[1;33mTimezone:\e[0m $(echo "$response" | jq -r '.timezone')"
    echo ""

    # Extract latitude and longitude
    loc=$(echo "$response" | jq -r '.loc')
    if [[ "$loc" != "null" ]]; then
        lat=$(echo "$loc" | cut -d ',' -f 1)
        lon=$(echo "$loc" | cut -d ',' -f 2)
        echo -e "\e[1;35mWould you like to open the location in Google Maps? (y/n):\e[0m"
        read open_map
        if [[ "$open_map" == "y" || "$open_map" == "Y" ]]; then
            maps_url="https://www.google.com/maps?q=$lat,$lon"
            echo -e "\e[1;36mOpening location in Google Maps...\e[0m"
            xdg-open "$maps_url" 2>/dev/null || open "$maps_url" 2>/dev/null || start "$maps_url" 2>/dev/null
            if [[ $? -ne 0 ]]; then
                echo -e "\e[1;31mFailed to open browser. You can manually visit the link below:\e[0m"
                echo -e "\e[1;34m$maps_url\e[0m"
            fi
        else
            echo -e "\e[1;33mLocation link not opened.\e[0m"
        fi
    else
        echo -e "\e[1;31mLocation data not available for this IP.\e[0m"
    fi
}

# Function to scan for open ports
scan_ports() {
    local ip_address=$1
    echo -e "\e[1;35mScanning for open ports on $ip_address...\e[0m"
    open_ports=$(nc -zv $ip_address 1-1024 2>&1 | grep "succeeded" | awk '{print $4}')
    if [[ -z "$open_ports" ]]; then
        echo -e "\e[1;31mNo open ports found in the range 1-10024.\e[0m"
    else
        echo -e "\e[1;32mOpen ports:\e[0m"
        echo "$open_ports"
        echo -e "\e[1;35mWould you like to establish a connection to an open port using netcat? (y/n):\e[0m"
        read connect_nc
        if [[ "$connect_nc" == "y" || "$connect_nc" == "Y" ]]; then
            echo -e "\e[1;33mEnter the port number to connect to:\e[0m"
            read port
            echo -e "\e[1;36mAttempting to connect to $ip_address on port $port...\e[0m"
            nc -v $ip_address $port
        else
            echo -e "\e[1;33mNetcat connection not initiated.\e[0m"
        fi
    fi
}

# Function to check Windows Defender firewall settings (Windows only)
check_windows_firewall() {
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        echo -e "\e[1;35mChecking Windows Defender firewall settings...\e[0m"
        firewall_rules=$(netsh advfirewall firewall show rule name=all | grep -E "Remote Desktop|Remote Service Management|Remote Shutdown|Remote Volume Management|Secure Socket Tunneling Protocol")
        if [[ -z "$firewall_rules" ]]; then
            echo -e "\e[1;31mNo relevant firewall rules found.\e[0m"
        else
            echo -e "\e[1;32mRelevant firewall rules:\e[0m"
            echo "$firewall_rules"
        fi
    else
        echo -e "\e[1;31mThis feature is only available on Windows.\e[0m"
    fi
}

# Main script
echo -e "\e[1;35mEnter the IP address to retrieve its details:\e[0m"
read ip_address

# Validate IP address format
if [[ $ip_address =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    get_ip_info "$ip_address"
    scan_ports "$ip_address"
    check_windows_firewall
else
    echo -e "\e[1;31mInvalid IP address format. Please try again.\e[0m"
fi





