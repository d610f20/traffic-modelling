#!/bin/bash

"$SUMO_HOME"/tools/randomTrips.py -n helloo.net.xml --route-file=helloo.rou.xml -e 2000 --period 3 --persontrips --trip-attributes "modes=\"public car\"" --additional-file helloo.add.xml

sleep 1
