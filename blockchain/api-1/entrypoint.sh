#!/bin/bash

if [[ -f "/data/server.lock" ]]; then
    echo "running broker..."
    /sirius/bin/catapult.broker /chainconfig
fi

if [[ -f "/data/broker.lock" ]]; then
    echo "running recovery..."
    /sirius/bin/catapult.recovery /chainconfig
fi

if [[ -f "/data/recovery.lock" ]]; then
    echo "unable to recover. Please run reset-node.sh script to reset node"
    exit 1
fi

/sirius/bin/sirius.bc /chainconfig