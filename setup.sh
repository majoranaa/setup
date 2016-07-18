#!/bin/bash
if [ "`uname`" == "Linux" ]; then # Linux OS
    ./setup_linux.sh
elif ["`uname`" == "Darwin" ]; then # Mac OS
    ./setup_mac.sh
fi
