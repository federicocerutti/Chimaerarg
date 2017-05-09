#!/bin/bash

ulimit -m 3850000
ulimit -v 3850000


timeout -s 9 295 ./labsat -p EE-ST -f $1 -fo apx


#real_tempo=`grep real ttt | cut -d " "  -f2`
#echo $real_tempo > tempo;
#w=`cat ccc`

#echo -n "["
 #               echo $w | sed 's/{/[/g' | sed 's/}/]/g' | tr -d '\n' \
  #                     | sed 's/\]\[/\],\[/g' | sed 's/\] \[/\],\[/g' | sed 's/in(//g' | sed 's/)//g'
   #             echo "]"


