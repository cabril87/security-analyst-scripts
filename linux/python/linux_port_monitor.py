#!/usr/bin/env python3
"""
A Python script to list open ports and their corresponding listening processes.
Uses the 'ss' command to capture this information on Linux systems.
"""

import subprocess

def get_open_ports():
    """
    Returns the raw output lines from 'ss -tulpn'.
    """
    try:
        result = subprocess.run(["ss", "-tulpn"], capture_output=True, text=True, check=True)
        return result.stdout.splitlines()
    except subprocess.CalledProcessError as e:
        print("Error running 'ss' command:", e)
        return []

def main():
    open_ports = get_open_ports()
    if not open_ports:
        return

    # The first line in ss -tulpn output is usually a header
    print("=== Open Ports & Listening Processes ===")
    for line in open_ports:
        print(line)

if __name__ == "__main__":
    main()

# Make it executable: chmod +x linux_port_monitor.py
# Run it: ./linux_port_monitor.py
