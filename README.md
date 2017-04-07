# arpscan
Simple bash script to perform ARP scan on the local network (The one you are currently connected to). Very handy when level 3 (or higher) scanning techniques fail due to filtering.

## Usage
    sudo ./arpscan.sh <device>

\<device>: The network device connected to the network you want to scan.

The script should be run as root.
You could add **CAP_NET_RAW** to the arping binary and modify the arpscan.sh script so you could run it as a normal user.

## Disclaimer
These scripts are free and unencumbered software released into the public domain.
The author is not responsible for any kind of usage of these scripts. Use them at your own risk.

## Note
The script forks itself n times where n is the number of IP addresses in the network. Don't use it against large networks (e.g. /16) as it will launch a huge number of child processes.

I am well aware that bash isn't the ultimate scripting language in which one can implement such functionality. I did it anyway for the fun of it, and because one friend of mine once told me it would be very difficult to get that done in bash. This proves him wrong :)
