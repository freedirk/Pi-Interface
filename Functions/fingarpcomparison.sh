#!/bin/bash
sudo fing -n 192.168.178.1/24 -r 1 -o table,csv,/tmp/fingarpcomptmp.tmp
sort -b /tmp/fingarpcomptmp.tmp > /home/admin/Logs/Fing/fingarpcompsorted.tmp
mv /home/admin/Logs/Fing/fingarpcompsorted.tmp /home/admin/Logs/Fing/ARPcomparison.csv

comm -123 /home/admin/Logs/Fing/ARPlogbaseline.csv /home/admin/Logs/Fing/ARPcomparison.csv> /home/admin/Logs/Fing/ARPcompresult.csv



alt1.gmail-smtp-in.l.google.com