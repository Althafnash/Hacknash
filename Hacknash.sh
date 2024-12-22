#!/bin/bash

echo ' ___ ___                __      _____    _______  ' 
echo '/   |   \_____    ____ |  | __ /  _  \   \      \  '
echo '/    ~    \__  \ _/ ___\|  |/ //  /_\  \  /   |   \ '
echo '\    Y    // __ \\  \___|    </    |    \/    |    \'
echo ' \___|_  /(____  /\___  >__|_ \____|__  /\____|__  /'
echo '      \/      \/     \/     \/       \/         \/ '

ping_target() {
    echo 'Enter the address: '
    read -r Address

    pingCount=4 

    if ping -c "$pingCount" "$Address" > /dev/null 2>&1; then
        echo "Success: $Address is reachable!"
    else 
        echo "Error: $Address is down or unreachable."
        exit 1
    fi
}

Nmap_Scan() {
    echo 'Enter the IP address: '
    read -r address
    sudo nmap "$address" -sV -O -p1-25565 -Pn
}

whatWeb_Scan() {
    echo 'Enter the host name or IP address: '
    read -r host 
    whatweb "$host"
}

TracePackets() {
    echo 'Enter the IP address: '
    read -r IP
    traceroute "$IP"
}

NetworkInterfaces(){
    echo "Showing all Network interfaces"
    ip a 
}

openports(){
    echo "Lets check for open ports"
    netstat -tuln 
    echo  "These are all the open ports"
}

NetworkDiscover(){
    echo "Lets check for open ports"
    Netdiscover
    echo  "These are all the open ports"
}

Main() {
    while true; do 
        echo 'What do you want to do? (Help,exit)'
        read -r Input

        if [ "$Input" = "ping" ]; then
            echo 'Pinging the address...'
            ping_target
            break
        elif [ "$Input" = "nmap" ]; then
            echo 'Scanning with Nmap...'
            Nmap_Scan
            break
        elif [ "$Input" = "whatweb" ]; then 
            echo 'Checking for what web server they are using...'
            whatWeb_Scan
            break
        elif [ "$Input" = "trace" ]; then 
            echo 'Tracing the packets...'
            TracePackets
            break
        elif [ "$Input" = "exit" ]; then
            echo 'Exiting the program. Goodbye!'
            break
        if [ "$Input" = "NetworkInterfaces" ]; then
            NetworkInterfaces 
        if [ "$Input" = "openports" ]; then
            openports 
        if [ "$Input" = "NetworkDiscover" ]; then
            NetworkDiscover 
        elif [ "$Input" = "Help" ]; then
            echo 'Commands : '
            echo 'ping' 
            echo 'nmap'
            echo 'whatweb'
            echo 'trace'
            echo 'NetworkInterfaces'
            echo 'openports'
            echo 'NetworkDiscover'
            echo 'exit' 
        else 
            echo 'Invalid option. Please try again.'
        fi 
    done
}

Main
