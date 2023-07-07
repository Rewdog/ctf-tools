#!/bin/bash
# Gobuster wrapper script
# Usage easy-bust <target> [type] [port] [wordlist]

# Set default values
target=${1}
type=${2:-"dir"}
port=${3:-80}
wordlist=${4:-"/usr/share/wordlists/dirb/common.txt"}

# Verify target parameter
if [[ -z "$target" ]]; then
    echo "Error: Missing target parameter."
    echo "Usage: easy-bust <target> [type] [port] [wordlist]"
    exit 1
fi

# Validate type parameter
valid_types=("dir" "dns" "vhost")
if ! [[ ${valid_types[*]} =~ $type ]]; then
    echo "Error: Invalid type parameter."
    echo "Type can be one of: ${valid_types[*]}"
    exit 1
fi

# Gobuster execution function
run_gobuster() {
    echo "Running Gobuster..."
    # Check if type is dns
    if [ $1 == "dns" ]
    then
        gobuster $1 -d $2 -w $4 -qz | tee $1-gobuster-$2.txt
    else
        gobuster $1 -u $2:$3 -w $4 -qz | tee $1-gobuster-$2.txt
    fi
}

# Run Gobuster with the given type
run_gobuster $type $target $port $wordlist
