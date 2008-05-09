#!/bin/sh

for a in `cat ./bulkmail`
	do
		echo -n "Adding $a..."
		sh fusion.sh $a
		echo " done"
	done
