#!/bin/bash
source /runtime/etc/configrc
wait-for-mysql.sh
cd /runtime/bin
./realmd
