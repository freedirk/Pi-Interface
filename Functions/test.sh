#!/bin/bash





cat hosts.txt | while read hname ipaddr ; do
	echo "it is [${hname}] and [${ipaddr}]"
done

