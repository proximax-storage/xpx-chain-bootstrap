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


rm -R $1/data/*
cp -R seed_data/* ./$1/data/

if [[ "$1" == "api-1" ]]
    then
        rm -R $1/mongodata/
        mkdir $1/mongodata/
fi