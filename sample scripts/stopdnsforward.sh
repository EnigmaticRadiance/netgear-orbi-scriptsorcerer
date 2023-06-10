#!/bin/sh
#fixes the router handing out itself as the dns server, and instead edits the config files to hand out any servers in /etc/resolv.conf 
#which are updated when the web gui dns servers are changed this will NOT dynamically do that.
#I made this because it was annoying not being able to seperate traffic by clients in my pihole.
#MAJOR NOTES: this will 100% break certain things. it might break access control, I haven't checked yet. 
#it DEFINITELY breaks orbilogin.net being the router homepage, make sure you know the ip.
#TODO kill processes related to dns forwarding? add PID check for dhcpv6, 
#TODO hook into the file which updates dns settings when they are changed in web gui so its fully dynamic!!!!! (idk where it is tho)

# Read the contents of /etc/resolv.conf into a variable (its more efficient than 2 fs reads (in my heart :broken_heart:))
resolv_conf=$(cat /etc/resolv.conf)

# Retrieve IPv4 and IPv6 addresses from the contents of /etc/resolv.conf & format them into the correct formatting for the dhcp conf files.
ipv4_addresses=$(echo "$resolv_conf" | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | tr '\n' ' ')
ipv6_addresses=$(echo "$resolv_conf" | grep ':' | awk '{print $2}' | tr '\n' ' ')

# Check if udhcpd is running and get its PID
udhcpd_pid=$(pgrep -f "udhcpd.*\/tmp\/udhcpd.conf")

# Function to handle IPv4 DNS configuration
function v4() {
    kill "$udhcpd_pid"
    sed -i "s/^option dns .*/option dns $ipv4_addresses/" /tmp/udhcpd.conf /etc/init.d/net-lan
    udhcpd /tmp/udhcpd.conf &
}

# Function to handle IPv6 DNS configuration
function v6() {
    sed -i "s|.*printf 'option domain-name-servers %s;\\\\n'.*|printf 'option domain-name-servers %s;\\\\n' \"$ipv6_addresses\"|g" /etc/net6conf/6service
    /etc/net6conf/6service reload &
}

# Check if udhcpd is running and that there is a valid IPv4 address in /etc/resolv.conf or don't execute
if [[ -n "$udhcpd_pid" ]] && [[ -n "$ipv4_addresses" ]]; then
    v4 &
fi

# Check if there are IPv6 addresses in /etc/resolv.conf before executing v6
if [[ -n "$ipv6_addresses" ]]; then
    v6 &
fi
