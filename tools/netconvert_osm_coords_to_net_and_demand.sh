#!/bin/bash
# Script to automagically generate SUMO network and demand-files with recommended options from OSM with coordinates

if [[ "$1" =~ --help ]]; then
	printf "Generates SUMO net-file from OSM network given by coords and models demand on that network\nUsage: \$script <W,S,E,N> <PREFIX>\n"
	printf "The coordinates and prefix are inputs. If not set, they will take defaults; Aalborg metro-area\n"
	exit 0
fi

SUMO_HOME='/home/user/projects/sumo'

# Use arguments as filenames
coord_input="$1"
osm_file_prefix="$2"

aalborg_osm_file_prefix="aalborg_metro"
osm_file_postfix="_bbox.osm.xml"
aalborg_coords="9.8012,56.9581,10.0765,57.1142"

# Set defaults
coord_input=${coord_input:=$aalborg_coords}
osm_file_prefix=${osm_file_prefix:=$aalborg_osm_file_prefix}

printf "Using SUMO_HOME:\t%s\nUsing coords:\t\t%s\nUsing prefix:\t\t%s\n" "$SUMO_HOME" "$coord_input" "$osm_file_prefix"

# Get Aalborg metropolitan area
printf "Running: osmGet.py --bbox %s --prefix %s\n" "$coord_input" "$osm_file_prefix"
$SUMO_HOME/tools/osmGet.py --bbox "$coord_input" --prefix "$osm_file_prefix"

# osmBuild uses recommended netconvert args by default
printf "Running: osmBuild.py --osm-file %s --prefix %s\n" "${osm_file_prefix}${osm_file_postfix}" "$osm_file_prefix"
$SUMO_HOME/tools/osmBuild.py --osm-file "${osm_file_prefix}${osm_file_postfix}" --prefix "$osm_file_prefix"

