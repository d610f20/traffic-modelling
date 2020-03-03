#!/bin/bash

extension=.exe

"$SUMO_HOME"/bin/netconvert$extension --node-files=hello.nod.xml --edge-files=hello.edg.xml --output-file=hello.net.xml
"$SUMO_HOME"/bin/sumo-gui$extension -c hello.sumocfg --demo
