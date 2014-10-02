#!/bin/bash
find $1 -name "*.php" |
while read file
do
n=$(grep -i mysql_connect $file | grep -vE '^[[:blank:]]*.*//' | grep -vw root | wc -l)
if [ $n -gt 0 ]
then
echo $file
#grep -E "mysql_(connect|select_db)" $file
grep -i mysql_connect $file
#sed -ie "s/localhost/icholvdbext01.ich.edu.pe/g" $file
echo ""
fi
done
