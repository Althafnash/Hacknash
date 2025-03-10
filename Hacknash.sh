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
    netdiscover
    echo  "These are all the open ports"
}

NetworkDiscover(){
    echo "Lets check for open ports"
    sudo netdiscover
    echo  "These are all the open ports"
}

DNSScanner(){
	echo 'Enter the name of the website You wanna LookUP'
	read Website 
	nslookup $Website 
}

WordPress(){
    echo 'Lets scan the webiste for vulnerabllities'
    echo 'Make sure that the website is made of wordpress'
    echo 'Use whatweb to check this'

    echo 'Enter the url for the wordpress website : '
    read website 
    wpscan --url $website  
}

WebserverScanner(){      
    echo 'Scaning  web servers for vulnerabilities and misconfigurations.'
    echo 'enter the web server address'
    read website 
    nikto -h $website
}

SubDomains(){
    echo 'Enuemrate subdomains'
    echo 'ENter the subdomain : '
    read subdomain
    amass enum -d $subdomain
}

DNSInformation(){
    echo 'Gather DNS information and about Subdomains'
    echo 'What is the website'
    read website 
    dnsenum $website 
}

ARPScanner(){
    echo "ARP scanning and checking providing device information"
    sudo arp-scan --localnet 
}

Wireshark(){
    echo "Which one do you want to run (1) wireshark or (2) tshark"
    read wire 
    if [ "$wire" = "wireshark" ]; then
        echo "starting wireshark..."
        sudo wireshark
    elif [ "$wire" = "tshark" ]; then 
        echo "starting tshark..."
        sudo tshark
    fi
}

Main() {
    while true; do 
        echo 'What do you want to do? (Help,exit)'
        read -r Input

        if [ "$Input" = "ping" ]; then
            echo 'Pinging the address...'
            ping_target
        elif [ "$Input" = "nmap" ]; then
            echo 'Scanning with Nmap...'
            Nmap_Scan
        elif [ "$Input" = "whatweb" ]; then 
            echo 'Checking for what web server they are using...'
            whatWeb_Scan
        elif [ "$Input" = "trace" ]; then 
            echo 'Tracing the packets...'
            TracePackets
        elif [ "$Input" = "exit" ]; then
            echo 'Exiting the program. Goodbye!'
            break
        elif [ "$Input" = "NetworkInterfaces" ]; then
            NetworkInterfaces 
        elif [ "$Input" = "openports" ]; then
            openports 
        elif [ "$Input" = "NetworkDiscover" ]; then
            NetworkDiscover
	    elif [ "$Inpunt" = "DNSScanner" ]; then 
	        DNSScanner 
        elif [ "$Input" = "WordPress" ]; then 
            WordPress
        elif [ "$Input" = "WebserverScanner" ]; then 
            WebserverScanner
        elif [ "$Input" = "SubDomains" ]; then 
            SubDomains
        elif [ "$Input" = "DNSInformation" ]; then 
            DNSInformation
        elif [ "$Input" = "ARPScanner" ]; then 
            ARPScanner
         elif [ "$Input" = "Wireshark" ]; then 
            Wireshark
        elif [ "$Input" = "Help" ]; then
            echo 'Commands : '
            echo 'ping' 
            echo 'nmap'
            echo 'whatweb'
            echo 'trace'
            echo 'NetworkInterfaces'
            echo 'openports'
            echo 'DNSScanner'
            echo 'WordPress'
	        echo 'NetworkDiscover'
            echo 'WebserverScanner'
            echo 'DNSInformation'
            echo 'ARPScanner'
            echo 'exit' 
        else 
            echo 'Invalid option. Please try again.'
        fi 
    done
}

Main
