# TCPdump-Poc

The vulnerability arises from improper handling of environment variables in the build.sh script. Specifically, the CC and PATH variables, which are used to define the compiler and executable search paths, are not sanitized or validated before being used in the build process. An attacker can set CC to a malicious script or executable that performs arbitrary actions when the script is executed.
