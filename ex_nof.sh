#!/bin/bash

ulimit -m 3700000
ulimit -v 3700000

rm -f ccc ttt tempo

{ time -p timeout -s 9 295 ./nofal $1 > ccc; } 2> ttt;


real_tempo=`grep real ttt | cut -d " "  -f2`
echo $real_tempo > tempo;
w=`cat ccc`

echo -n "["
                echo $w | sed 's/{/[/g' | sed 's/}/]/g' | tr -d '\n' \
                       | sed 's/\]\[/\],\[/g' | sed 's/\] \[/\],\[/g' | sed 's/in(//g' | sed 's/)//g'
                echo "]"


