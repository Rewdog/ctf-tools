
# CTF Tools

This is my collection of scripts I use when I'm tackling Capture The Flag (CTF) challenges. They're designed to automate some routine tasks and make life a little easier. Feel free to use them yourself.

## Installation

You can install these scripts using the `install-scripts.sh` script provided in this repository. It will copy the scripts to your `/usr/local/bin/` directory and make them executable, so you can run them from any location on your system.

```bash
chmod +x install-scripts.sh
./install-scripts.sh
```

**Note:** You might need to use `sudo` to run the installation script, depending on your permissions.

## The Tools

### rewcon

`rewcon.sh` is a reconnaissance script that takes the IP address of a target machine and performs a few initial steps of a CTF challenge:

- It creates a markdown notes file named after the current directory.
- It runs an Nmap scan and saves the results in the notes file.
- If it detects any HTTP(s) services, it will also run Gobuster for directory brute-forcing and WhatWeb for web server analysis, saving these results in the notes file as well.

Usage: 
```bash
rewcon <IP>
```

### easy-bust

`easy-bust.sh` is a wrapper for Gobuster, a tool used for directory and DNS enumeration. It accepts several parameters:

- `target`: The target IP or URL (required)
- `type`: The type of Gobuster scan - `dir`, `dns`, or `vhost`. Default is `dir`.
- `port`: The port to scan. Default is 80.
- `wordlist`: The path to the wordlist file. Default is `/usr/share/wordlists/dirb/common.txt`.

Usage: 
```bash
easy-bust <target> [type] [port] [wordlist]
```

### set-myip
`set-myip.sh` is a quick utility to put your IP into $myip environment variable for the session

- `-i`: Interactive mode, which will list your IPs and interfaces and allow you to choose. If not specified, tun0 will be used.

Usage:
```
. set-myip -i

echo $myip
```

### start-webserver
start-webserver.sh sets up a simple HTTP server for Capture The Flag (CTF) challenges. This script sets up a local web server in the directory www which contains shell scripts for reverse shell and a latest version of the linpeas enumeration tool.

- It checks if the $myip environment variable is set, if not, it runs set-myip script.
- It creates a new directory www in the current directory.
- It downloads the latest version of linpeas from its official GitHub repository and places it in the www directory.
- It creates a shell.sh file in the www directory, which can be used to initiate a reverse shell.
- It starts a Python3 HTTP server on port 4444.
- It prints out a set of useful commands related to the reverse shell and linpeas for quick copying.

Usage:

```
start-webserver
```

## Please Use Responsibly

These scripts are intended for ethical hacking purposes only, such as Capture The Flag (CTF) challenges or authorized penetration testing.

## Contributions Welcome

If you have suggestions or improvements, or if you find a bug, feel free to open an issue or make a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE.md) file for details.

