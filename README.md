# IPHIEuX
this is advanced Ip tool used to spote selected IP and check the IP infor and scan for open ports then control the shell of the IP's shell command this tool is for education purpose only 
# IPHIEuX v3.5 - Installation Guide

## Requirements

To run this script, ensure the following tools are installed on your system:

1. **`curl`**: Used for making HTTP requests.
   - Install on Ubuntu/Debian:
     ```bash
     sudo apt install curl
     ```
   - Install on macOS (pre-installed by default):
     ```bash
     brew install curl
     ```

2. **`jq`**: Used for parsing JSON responses.
   - Install on Ubuntu/Debian:
     ```bash
     sudo apt install jq
     ```
   - Install on macOS:
     ```bash
     brew install jq
     ```

3. **`netcat` (or `nc`)**: Used for port scanning and establishing connections.
   - Install on Ubuntu/Debian:
     ```bash
     sudo apt install netcat
     ```
   - Install on macOS:
     ```bash
     brew install netcat
     ```

4. **`xdg-open` (Linux) / `open` (macOS) / `start` (Windows)**:
   - These commands are usually pre-installed on their respective operating systems.

## Running the Script

1. Clone the repository:
   ```bash
   git clone https://github.com/yEphraimSib/IPHIEuX.git
   cd IPHIEuX
   ./IPHIEuX.sh or bash IPHIEuX.sh
