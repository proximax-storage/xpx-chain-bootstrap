#!/bin/bash

node_arr=("api-1" "p2p-1" "p2p-2" "p2p-3")

echo "backing up nemesis block"
sudo mv p2p-1/data/00000/00001.dat p2p-1/data/00000/hashes.dat /tmp

for c in "${node_arr[@]}"
do
    echo "deleting $c data directory"
    for dir in $c/data/*; do
        sudo rm -rf $dir
    done
    if [ -d "$c/mongodata" ]; then
        echo "deleting $c mongodata directory"
        for dir in $c/mongodata/*; do
            sudo rm -rf $dir
        done
    fi
    mkdir $c/data/00000
    sudo cp /tmp/00001.dat /tmp/hashes.dat $c/data/00000/
    if [ ! -f "$c/data/index.dat" ]; then
    echo "No index.dat file, creating now...."
    echo -ne "\01\0\0\0\0\0\0\0" > $c/data/index.dat
    fi
    echo "$c data has been reset to nemesis block"
done

sudo rm /tmp/00001.dat /tmp/hashes.dat
echo "blockchain has been reset"