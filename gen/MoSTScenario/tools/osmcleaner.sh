#!/bin/bash

# Monaco SUMO Traffic (MoST) Scenario
# Author: Lara CODECA

for file in $(find data -name '*.osm' ! -type l)
do
  # echo " Cleanin $file ..."
  osmfilter $file --drop=action=delete -o=$file.clean > /dev/null 2>&1
  if [ -f $file.clean ]; then
    if ! cmp -s $file $file.clean; then
      mv -v $file.clean $file
    else
      rm $file.clean
    fi
  fi
done
