#!/bin/bash

echo "=================="
echo "Paste files"
echo "=================="

for n in $(cat assets.txt | sed 's/[^(a-zA-Z0-9)^(-_/\.)]//g')
do
  echo -e "Pasting into rodsilva@ashcvrbocdn01a.sea.corp.expecn.com:/mnt/rsrcs/files/${n}"
  scp ./temp/${n} rodsilva@ashcvrbocdn01a.sea.corp.expecn.com:/mnt/rsrcs/files/${n}
done