#!/bin/bash

"$SUMO_HOME"/bin/activitygen.exe --net-file activitygen-example.net.xml --stat-file activitygen-example.stat.xml --output-file activitygen-example.trips.rou.xml --random

"$SUMO_HOME"/bin/duarouter.exe --net-file activitygen-example.net.xml --route-files activitygen-example.trips.rou.xml --output-file activitygen-example.rou.xml --ignore-errors

"$SUMO_HOME"/bin/sumo-gui.exe --net-file activitygen-example.net.xml --route-files activitygen-example.rou.xml
