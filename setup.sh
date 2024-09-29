#!/bin/bash

# Grant access to /dev/uinput device
# https://github.com/ReimuNotMoe/ydotool/issues/36
# https://gabrielstaples.com/ydotool-tutorial

if [ "$EUID" -ne 0 ]
    then echo "=> Please run as root"
    exit
fi

apt install ydotool ydotoold

# Allow regular user to access uinput device
echo 'KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"' > /etc/udev/rules.d/60-uinput.rules

# Reload udev rules
udevadm control --reload-rules && udevadm trigger
