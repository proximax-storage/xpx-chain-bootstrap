#!/bin/bash

node_arr=("api-1" "p2p-1" "p2p-2" "p2p-3")

valid_node=0

for c in "${node_arr[@]}"
do
    if [[ "${c}" == "$1" ]]
    then
        valid_node=1
        break
    fi
done

# Check if node is valid
if [[ ${valid_node} -eq 0 ]]
    then
        echo "Invalid node.\n Usage: './reset_node.sh <node>' where node = 'api-1','p2p-1','p2p-2','p2p-3'"
        exit 1
fi


echo "backing up nemesis block"
mv $1/data/00000/00001.dat $1/data/00000/hashes.dat /tmp
echo "deleting data directory"

for dir in $1/data/*; do
    rm -rf $dir
done

if [ -d "$1/mongodata" ]; then
    echo "deleting mongodata directory"
    for dir in $1/mongodata/*; do
        sudo rm -rf $dir
    done
fi

mkdir $1/data/00000
mv /tmp/00001.dat /tmp/hashes.dat $1/data/00000/

if [ ! -f "$1/data/index.dat" ]; then
    echo "No index.dat file, creating now...."
    echo -ne "\01\0\0\0\0\0\0\0" > $1/data/index.dat
fi
echo "$1 data has been reset to nemesis block"