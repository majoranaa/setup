#!/bin/bash
if [ "`uname`" == "Linux" ]; then
    ./setup_linux.sh
elif ["`uname`" == "Darwin" ]; then
    ./setup_mac.sh
fi
