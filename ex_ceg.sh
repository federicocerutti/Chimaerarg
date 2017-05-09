#!/bin/bash

ulimit -m 3700000
ulimit -v 3700000

rm -f aaa 

timeout -s 9 445 ./cegartix $1 -semantics=pref -mode=enum -argument= -oracle=clasp -depthArg=-1 > aaa;

h=`grep "terminated" aaa | wc -l`
w=`cat aaa`
if [ "$h" -gt "0" ]; then
	echo -n "["
echo -n $w | sed 's/,\]/\]/g' | sed 's/terminated.*//' | sed 's/\]\[/\],\[/g'
echo "]"
	exit 0
else
	exit -1
fi



