#!/bin/bash

cat $1 | awk '{ print $1, $2 }' > sed.txt
sleep 2
sed -i 's/ /@/g' sed.txt
sleep 2
input=sed.txt
while IFS= read -r line
do
  snyk test $line | grep "for known vulnerabilities" >>results.txt
done < "$input"

sleep 2
cat results.txt | grep -v "no vulnerable paths found." >vulnerable.txt
rm -r sed.txt
echo "Scanning Done"
