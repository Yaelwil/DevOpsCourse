#!/bin/bash

IP_address_Private_Machine="$1"
ipv4_regex='^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'
Initial_Key_Path=~/Initial_key.pem
KEY_PATH=~/old_key

# Divide the cases if I get 0 OR 1 arguments
if [ $# -eq 0 ]; then
        echo "Please provide IP address"
        exit 5
elif [ $# -eq 1 ]; then
        if echo "$IP_address_Private_Machine" | grep -P -q "$ipv4_regex"; then
                # Rename the old key file
                mv "/home/ubuntu/new_key" "/home/ubuntu/old_key" &> /dev/null
                mv "/home/ubuntu/new_key.pub" "/home/ubuntu/old_key.pub" &> /dev/null
                # Set the desired new key file name
                key_file="/home/ubuntu/new_key"
                # Run ssh-keygen non-interactively without a passphrase
                ssh-keygen -f "$key_file" -N "" &> /dev/null
                # check if there is the initial key file
                if [ -e "$Initial_Key_Path" ]; then
                        scp -i $Initial_Key_Path ~/new_key.pub ubuntu@$IP_address_Private_Machine:~/.ssh &> /dev/null
                        if [ $? -eq 0 ]; then
                                ssh -i $Initial_Key_Path ubuntu@$IP_address_Private_Machine 'cat ~/.ssh/new_key.pub >> ~/.ssh/authorized_keys'
                                        if [ $? -eq 0 ]; then
                                                Text_To_Delete=$(cat /home/ubuntu/old_key.pub 2> /dev/null)
                                                ssh -i $Initial_Key_Path ubuntu@$IP_address_Private_Machine "sed -i '/$(echo "$Text_To_Delete" | sed -e 's/[\/&]/\\&/g')/d' ~/.ssh/authorized_keys" &> /dev/null
                                                chmod +w $Initial_Key_Path
                                                chmod +w ~/initial_key.pub
						rm $Initial_Key_Path &> /dev/null
                                                rm ~/Initial_key.pub" &> /dev/null
                                                rm "/home/ubuntu/old_key" &> /dev/null
                                                rm "/home/ubuntu/old_key.pub" &> /dev/null
                                        else
                                                exit 5
                                        fi
                        else
                                exit 5
                        fi
                elif [ ! -e "$Initial_Key_Path" ]; then
                        scp -i $KEY_PATH ~/new_key.pub ubuntu@$IP_address_Private_Machine:~/.ssh &> /dev/null

                        # Only proceed if the above command worked
                        if [ $? -eq 0 ]; then
                                ssh -i $KEY_PATH ubuntu@$IP_address_Private_Machine 'cat ~/.ssh/new_key.pub >> ~/.ssh/authorized_keys'
                                if [ $? -eq 0 ]; then

                                        Text_To_Delete=$(cat /home/ubuntu/old_key.pub 2> /dev/null)
                                        ssh -i $KEY_PATH ubuntu@$IP_address_Private_Machine "sed -i '/$(echo "$Text_To_Delete" | sed -e 's/[\/&]/\\&/g')/d' ~/.ssh/authorized_keys" &> /dev/null
                                        rm "/home/ubuntu/old_key" &> /dev/null
                                        rm "/home/ubuntu/old_key.pub" &> /dev/null
                                else
                                        exit 5
                                fi
                        else
                                exit 5
                        fi
                fi
        else
                echo "Provide a valid IP"
                exit 5
        fi
fi
