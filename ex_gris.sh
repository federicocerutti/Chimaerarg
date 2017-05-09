#!/bin/bash

ulimit -m 3700000 
ulimit -v 3700000

export MAXTIME="600"

./apx2tgf.sh $1 > qui

rm -rf bbb

timeout -s 9 145 ./gris -p EE-PR -f qui -fo tgf > bbb;

h=`grep "]]" bbb | wc -l`

if [ "$h" -gt "0" ]; then
echo $bbb
fi
