#!/bin/bash
# Take the name of the folder you are in and create a notes file
# Runs nmap, gobuster, and whatweb
# Usage: rewcon <IP>

if [ -z "$1" ]
then
        echo "Usage: rewcon <IP>"
        exit 1
fi

#setup notes file
boxname=$(basename "$PWD")
notes="$boxname-notes.md"
touch $notes
printf "# $boxname - $1 \n" > $notes

echo "Scanning $boxname at $1"

# nmap
echo "Running Nmap..."
printf "## nmap \n" >> $notes
printf "sudo nmap -sC -sV -A $1 \n\n" >> $notes
sudo nmap -sC -sV -A $1 >> $notes

# gobuster and whatweb if http(s) open
while read line
do
        if [[ $line == *open* ]] && [[ $line == *http* ]]
        then
                echo "Running Gobuster..."
                gobuster dir -u $1 -w /usr/share/wordlists/dirb/common.txt -qz > temp1

        echo "Running WhatWeb..."
        whatweb $1 -v > temp2
        fi
done < $notes

# append gobuster and whatweb results to notes
if [ -e temp1 ]
then
        printf "## DIRS -----\n\n" >> $notes
        cat temp1 >> $notes
        rm temp1
fi

if [ -e temp2 ]
then
    printf "## WEB -----\n\n" >> $notes
        cat temp2 >> $notes
        rm temp2
fi

cat $notes