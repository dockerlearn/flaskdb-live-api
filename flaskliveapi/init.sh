#!/bin/sh
set -e

echo "Starting SSH ..."
#rc-update add sshd
#service sshd start

python3 app.py runserver 0.0.0.0:5000
