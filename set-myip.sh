#!/bin/bash
# Usage: source set-myip.sh [-i]
# If the -i flag is passed, the user will be prompted to select an interface
# otherwise, the IP address of tun0 will be used

# Function to parse the IP address and interface name
get_interfaces() {
    while IFS= read -r line
    do
        iface=$(echo "$line" | awk '{print $2}')
        ip=$(echo "$line" | awk '{print $4}' | cut -f1 -d'/')
        echo "$iface $ip"
    done < <(ip -o -4 addr show)
}

# If the flag is -i
if [ "$1" = "-i" ]; then
    IFS=$'\n'   # Set IFS to newline for the select options
    PS3="Please choose an interface: "
    select option in $(get_interfaces); do
        # Check if the user has made a valid selection
        if [[ -n "$option" ]]; then
            # Export the selected IP as an environment variable
            myip=$(echo $option | awk '{print $2}')
            echo "myip is set to $myip"
            break
        else
            echo "Invalid selection. Please try again."
        fi
    done
    unset IFS   # Reset IFS to its original value
else
    # Get the IP address of tun0
    IP=$(ip addr show tun0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)

    # Check if we got an IP address
    if [[ -n "$IP" ]]; then
        # Set it as a shell variable
        myip=$IP
        echo "myip is set to $myip"
    else
        echo "No IP address found for tun0. Exiting."
        exit 1
    fi
fi

# Export myip as an environment variable
export myip
