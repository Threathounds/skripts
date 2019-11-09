#!/bin/bash
# author: ide0x90

display_usage()
{
    echo "Usage: http_pwd.sh <pcap_file>"
}

if [  $# -le 0 ]
then
    display_usage
    exit 1
fi

if [[ ( $1 == "--help") || ( $1 == "-h" ) ]]
then
    display_usage
    exit 1
fi


decode()
{
    : "${*//+/ }"; echo -e "${_//%/\\x}";
}

if [[ ( $1 == *"pcap" ) || ( $1 == *"pcapng" ) || ( $1 == *"cap"*) ]]
then
    var1=$(tshark -Y "http.request.method == POST && http.content_type contains "x-www-form-urlencoded"" -T fields -e text -e http.file_data -r $1 2>/dev/null | cut -f 2 -d '  ')
    decode "$var1"
    exit 0
else
    echo "No compatible pcap/pcapng file found!"
    exit 1
fi
