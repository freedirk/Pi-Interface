#!/bin/bash

sudo fing -n 192.168.178.1/24 -r 1 -o table,csv,/tmp/ARPlogbaseline.tmp
sort -b /tmp/ARPlogbaseline.tmp > /tmp/ARPlogbasesorted.tmp
mv /tmp/ARPlogbasesorted.tmp /home/admin/Logs/Fing/ARPlogbaseline.csv
