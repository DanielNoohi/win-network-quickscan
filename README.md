# win-network-quickscan.bat

**Automated Windows Network Discovery & Quick Port Scanner for IT Admins**

---

## Overview

`win-network-quickscan.bat` is a simple but powerful batch script for Windows that helps IT administrators instantly audit their local network.  
The script automatically installs Nmap if it's missing, scans your subnet to detect live hosts, identifies Windows machines, and scans open ports on those hosts—presenting all results live in your terminal.

---

## Features

- **Automatic Nmap Installation**  
  Checks if Nmap is installed; downloads and installs it if missing.

- **Network Scanning**  
  Scans your local subnet to discover all online devices.

- **Windows Host Detection**  
  Uses Nmap OS detection to find Windows-based hosts.

- **Open Port Scanning**  
  Performs a full port scan on each detected Windows host.

- **Live Results**  
  Prints all findings directly to the terminal for rapid action.

---

## Usage

1. **Clone or download** this repository.
2. Edit the `NETWORK_RANGE` variable inside the script if your subnet is different (default: `192.168.1.0/24`).
3. **Run as Administrator**:  
   Right-click the script and select “Run as administrator” to ensure full functionality.

```cmd
win-network-quickscan.bat
