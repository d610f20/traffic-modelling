#!/usr/bin/env python3

import sys
import os

if "SUMO_HOME" not in os.environ:
    print("SUMO_HOME is not set")
    sys.exit(1)

sumolib_path = os.path.join(os.environ.get("SUMO_HOME"), "tools")
sys.path.append(sumolib_path)

import sumolib

# TODO
