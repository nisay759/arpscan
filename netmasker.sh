#!/bin/bash

export PATH="/usr/bin"

#check if the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

#functions definition
function usage {
    echo "Usage: $0 <device>"
    echo 
    echo "Simple script for arp scanning the network you are currently connected to."
    echo "Bugs & questions: nisay@minet.net"

    exit 1
}

function noNetwork {
    echo "The specified device doesn't seem to be connected to any network !"
    exit 1
}

function scanARP() {
    arping -I $1 $2 -c 1 -q && echo $2
}

#User input validation
[ $# -ne 1 ] && usage

dev=$1

ip=$(ip a show dev $dev | grep -Eo 'inet .* brd' | cut -f2 -d' ') 

[[ -z $ip ]] && exit 1 

NETMASK=$(echo $ip | cut -d'.' -f4 | cut -d'/' -f2)

[[ -z $NETMASK ]] && noNetwork

for i in $(./netmasker.sh $ip | tail -n +2 | head -n -1); do
    scanARP $dev $i &
done

wait
exit 0
