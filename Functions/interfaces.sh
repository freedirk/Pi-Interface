#!/bin/bash


echo -e "Content-type: text/html\r\n\r\n"
###
### NetPi Interface IP Information Visual Script
### Ifconfig tossed to a log and html file
###
#######################################
# Define the ifconfig results as a var#
#######################################
dtstamp=$(date +"%m-%d-%Y--%H%M")
intdata=$(ifconfig)
#######################################
# HTML Content // Edit to your needs #
#######################################
open="<html><head><link rel="stylesheet" href="../css/bootstrap.css"></head><body><h1>Interface Details</h1><pre>"
close="</pre><br/><input
type='button' value='New Scan'/></body></html>"
######################################
# Write content to HTML file #
######################################
_file="/home/admin/Logs/interfaces"
echo "$intdata" > "$_file/intlog-$dtstamp.txt"
echo "$open" > "$_file/intreport.shtml"
echo "$intdata" >> "$_file/intreport.shtml"
echo "$close" >> "$_file/intreport.shtml"
#echo "$intdata"
#####################################
#cat "$_file/intreport.html"
#####################################
