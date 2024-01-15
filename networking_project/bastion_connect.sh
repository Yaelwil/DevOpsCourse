#!/bin/bash

# Set variables
IP_address_Public_Machine="$1"
IP_address_Private_Machine="$2"
ipv4_regex='^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'
command="${@:3}"

# Check if KEY_PATH environment variable is set
if [ -z "$KEY_PATH" ]; then
  echo "Error: KEY_PATH environment variable is not set."
  exit 5
fi

# Devide the cases if I get 0,1, or 2 arguments
if [ $# -eq 0 ]; then
	echo "Please provide IP adderss"

elif [ $# -eq 1 ]; then
        # check if the IP is valid
        if echo "$IP_address_Public_Machine" | grep -P -q "$ipv4_regex"; then
                ssh -i $KEY_PATH ubuntu@$IP_address_Public_Machine
        else
                echo "Invalid IP address: $ip_address"
                exit 5
        fi
elif [ $# -eq 2 ]; then
        # check if the IPs are valid
	if echo "$IP_address_Public_Machine" | grep -P -q "$ipv4_regex" && echo "$IP_address_Private_Machine" | grep -P -q "$ipv4_regex"; then
		if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
			# check if my private key is in the local ssh agent
			if ssh-add -l | grep -q $KEY_PATH; then

				# if the local ssh agent have my private key, connecting using jump proxy
				ssh -i $KEY_PATH -J ubuntu@$IP_address_Public_Machine ubuntu@$IP_address_Private_Machine
			else
                        	# if the local ssh agent doesn't have my private key, add it to the file and  connect using jump proxy
                        	ssh-add $KEY_PATH
				ssh -i $KEY_PATH -J ubuntu@$IP_address_Public_Machine ubuntu@$IP_address_Private_Machine
		fi	fi
        else
                echo "Invalid IP address: $ip_address"
                exit 5
        fi
elif [ $# -eq 3 ]; then
        # check if the IPs are valid
        if echo "$IP_address_Public_Machine" | grep -P -q "$ipv4_regex" && echo "$IP_address_Private_Machine" | grep -P -q "$ipv4_r"; then
		if [ -z "$SSH_AUTH_SOCK" ]; then
			eval "$(ssh-agent -s)"
                	# check if my private key is in the local ssh agent
                	if ssh-add -l | grep -q $KEY_PATH; then

                        	# if the local ssh agent have my private key, connecting using jump proxy
                        	ssh -i $KEY_PATH -J ubuntu@$IP_address_Public_Machine ubuntu@$IP_address_Private_Machine "$command"
                	else
                        	# if the local ssh agent doesn't have my private key, add it to the file and  connect using jump proxy
                       		ssh-add $KEY_PATH
                        	ssh -i $KEY_PATH -J ubuntu@$IP_address_Public_Machine ubuntu@$IP_address_Private_Machine "$command"
                	fi
        	fi
	else
                echo "Invalid IP address: $ip_address"
                exit 5
        fi

fi
