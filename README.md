# TCPdump-Poc
A vulnerability has been discovered in the tcpdump build script (build.sh) where arbitrary code can be executed by manipulating environment variables, particularly CC and PATH. These environment variables are used without proper validation, enabling an attacker to inject malicious commands. 
