#!/bin/bash

# Check if expect is installed
if ! command -v expect >/dev/null; then
    echo "This script requires 'expect' but it's not installed."
    echo "Install it using Homebrew with 'brew install expect'."
    exit 1
fi

# Start the telnet session and handle interactions
expect <<'EOF'
# Set a reasonable timeout for commands
set timeout 1

# Start telnet session
spawn telnet {{DESTINATION_IP}} 10000

# Expect the password prompt
expect "PASSWORD:"
# Send a carriage return to simulate pressing enter (assuming no password needed)
send "\r"

# Wait for an indication that the session is ready for commands
# This should be replaced with whatever message or prompt you see when it's ready to receive commands
expect "Hello"

# Send the command. Adjust this command to whatever you need to send after the initial login.
send "{{COMMAND}}\r"

# Wait for any response that indicates the command was processed
# You need to adjust "done" to the specific message you expect to see after sending your command
expect "done"

# Send the Control-C to terminate the session
send "\x03"

# Wait for the session to close
expect eof
EOF

echo "Session complete."

