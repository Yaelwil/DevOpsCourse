# Networking Project

In the networking project I did the following steps-

First, I needed to set up a VPC, two subnets, network ACLs, routing tables, an internet gateway, and security groups in AWS.

The first subnet connects the external internet to the VPC.
The second subnet is reserved for internal connections solely within the VPC.

I built two instances-
The first, public, was associated with the subnet connection between the external internet and VPC.
The second instance, named private, was coupled with the second subnet's internal connection.

In the Security Groups section, I allowed communication to and from ports 22 (bastion_connect.sh and key_rotation.sh), 8080 (tls_handshake.sh).

In the first assignment, I needed to write a script that could connect to the first instance, the second instance, or the internal instance and execute a command.
The script can be found in 'bastion_connect.sh'.

In the second assignment, I had to write a script that can rotate keys (for security reasons) while still allowing you to connect using 'bastion_connect.sh'.
The script can be found in 'key_rotation.sh'.

In the third assignment, I created a script to manually implement a TLS handshake to validate the validity of a site before accessing in. The script can be found in 'tls_handshake.sh'.

## Operating Systems:
-	Linux (Ubuntu): File System Management, Permissions, Processes, Services.
## Programming Languages:
-	Bash Scripting: Environment Variables, Conditional Statements.
## Cloud:
-	AWS: VPC, EC2, Security Groups.
## Networking:
-	OSI Model, Protocols, HTTP.
## Security:
- OpenSSL, SSH, Encryption, Cryptography.
-	Networking Security.
