#!/usr/bin/env bash

USAGE="Usage: $0 public-key-file
Adds necessary setup for each host for passphraseless login.
Parameters:
    public-key-file   Path to public key file which will be copied to all hosts in config.

Script will ask for password for each host.
"

usage () {
    echo "$USAGE" >&2
    exit 1
}

check-pub-key-file () {
  if [ ! -f "$1" ]
  then
    echo "Public key file not found: $1" >&2
    exit 1
  fi
  ssh-keygen -l -f $1
  if [ $? -ne 0 ]
  then
    echo "Public key file does not look valid $1" >&2
    exit 1
  else
    echo "Public key file looks valid."
  fi
}

[ -n "$1" ] || usage

check-pub-key-file "$1"

hostsArray=()
#read all lines which don't start with hash from ./hosts file
while read -r line; do
    if [[ $line != \#* ]]; then
        hostsArray+=("$line")
    fi
done < ./hosts

for host in ${hostsArray[@]}; do
    echo "Copying public key to $host"
    ssh-copy-id -i $1 $host
    echo "Checking connectivity to $1 (you should not be required to type password...)"
    ssh $host 'echo "Host is reachable"'
done

