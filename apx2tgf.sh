grep arg $1 | sed 's/arg(//g' | sed 's/)\.//g'
echo "#"
grep att $1  | sed 's/att(//g' | sed 's/)\.//g' | sed 's/,/ /g'
