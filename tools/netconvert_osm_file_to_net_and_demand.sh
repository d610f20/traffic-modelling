#!/bin/bash
# Script to automagically generate SUMO network and demand-files with recommended options

if [[ "$1" =~ --help ]] || [[ $# -le 2 ]]; then
	printf "Generates SUMO net-file from OSM network and models demand on that network\nUsage: \$script <NETWORK.osm> <NETWORK.net.xml> <ROUTE.rou.xml>\n"
	printf "The .osm file is input, .net.xml and rou.xml is output files. If not set, they will take the input network's name\n"
	exit 0
fi

SUMO_HOME='/home/user/projects/sumo'

# Use arguments as filenames
net_input="$1"
net_output="$2"
route_output="$3"

printf "Using $SUMO_HOME: %s\n" "$SUMO_HOME"

recommended_args="--geometry.remove --ramps.guess --roundabouts.guess --junctions.join --tls.guess-signals --tls.discard-simple --tls.join"

printf "##########\nRecommended netconvert args: %s\n##########\n" "$recommended_args"

printf "Using net in:\t\t%s\nUsing net out:\t\t%s\nUsing route out:\t%s\n" "$net_input" "$net_output" "$route_output"

# Run NETCONVERT
netconvert --osm-files "$net_input" -o "$net_output" "$recommended_args"

random_trips_args="-e 3600 --fringe-factor 10"
printf "##########\nRecommended randomTrips args: %s\n##########\n" "$random_trips_args"

$SUMO_HOME/tools/randomTrips.py -n "$net_output" -r "$route_output" "$random_trips_args"
