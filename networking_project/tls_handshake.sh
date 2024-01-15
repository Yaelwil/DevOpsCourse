#!/bin/bash

# Define variables-

# Server IP and port
SERVER_IP=$1
SERVER_PORT=$2

	# Client Hello message data
	CLIENT_HELLO_DATA='{
   	"version": "1.3",
   	"ciphersSuites": [
      	"TLS_AES_128_GCM_SHA256"
   	],
   	"message": "Client Hello"
}'

	# Check if jq is installed, install it if not
	command -v jq &> /dev/null
	if [ $? -ne 0 ]; then
    		sudo apt install jq
	fi

	# Perform the POST request and store the response in a variable
	RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" -d "${CLIENT_HELLO_DATA}" "$SERVER_IP:$SERVER_PORT/clienthello")

	# Use jq to parse and extract keys from the JSON response
	SESSION_ID=$(echo "${RESPONSE}" | jq -r '.sessionID')
	SERVER_CERT=$(echo "${RESPONSE}" | jq -r '.serverCert')

	# Print the extracted values
	echo "Session ID: ${SESSION_ID}"
	echo "Server Certificate:"
	echo "${SERVER_CERT}"
	echo "${SERVER_CERT}" > cert.pem

	# Download the website certificate from the CA
	# need to change this part in order for the rest of the script to work
	#wget  < URL to certificate >

	# Verify the server certificate from the curl command and the one I downloaded
	openssl verify -CAfile cert-ca-aws.pem cert.pem

	if [ $? -ne 0 ]; then
    	echo "Server Certificate is invalid"
    	exit 5
	fi

	# Generate 32 random bytes matser key
	ORIGINAL_MASTER_KEY=$(openssl rand -base64 32)

	# Save the master key to a file
	echo "$ORIGINAL_MASTER_KEY" > ~/original_master_key.txt

	echo "Generated master key:"
	echo "$ORIGINAL_MASTER_KEY"
	echo "Master key saved to original_master_key.txt"

	# Encrypt the master key
	MASTER_KEY=$(openssl smime -encrypt -aes-256-cbc -in ~/original_master_key.txt -outform DER ~/cert.pem | base64 -w 0)
	echo $MASTER_KEY > ~/encrypted_master_key.txt

	# Send the encrypted master key to the server
	KEY_EXCHANGE_DATA='{
    	"sessionID": "'$SESSION_ID'",
    	"masterKey": "'$MASTER_KEY'",
    	"sampleMessage": "Hi server, please encrypt me and send to client!"
}'

	KEY_EXCHANGE_RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" -d "${KEY_EXCHANGE_DATA}" "http://${SERVER_IP}:${SERVER_PORT}/keyexchange")

	# Use jq to parse and extract keys from the key exchange response
	SESSION_ID_EXCHANGE=$(echo "${KEY_EXCHANGE_RESPONSE}" | jq -r '.sessionID')
	ENCRYPTED_SAMPLE_MESSAGE=$(echo "${KEY_EXCHANGE_RESPONSE}" | jq -r '.encryptedSampleMessage')
	ORIGINAL_MESSAGE=$(echo "${KEY_EXCHANGE_DATA}" | jq -r '.sampleMessage')

	# Print the extracted value
	echo "Session ID: ${SESSION_ID_EXCHANGE}"
	echo "Encrypted Sample Message:"
	echo "${ENCRYPTED_SAMPLE_MESSAGE}"

	# Decode the base64-encoded encrypted sample message
	echo "${ENCRYPTED_SAMPLE_MESSAGE}" | base64 -d > ~/encSampleMsgReady.txt

	# Decrypt the sample message using RSA private key
	openssl enc -d -aes-256-cbc -salt -pbkdf2 -in ~/encSampleMsgReady.txt -out ~/decrypted_message.txt -pass file:/home/ubuntu/original_master_key.txt
	DECRYPTED_MESSAGE=$(<~/decrypted_message.txt)

	# Compare the original and decrypted messages
	if [ "${ORIGINAL_MESSAGE}" != "${DECRYPTED_MESSAGE}" ]; then
    		echo "Server symmetric encryption using the exchanged master-key has failed."
     		exit 6      
	else
    		echo "Client-Server TLS handshake has been completed successfully"
	fi
fi
