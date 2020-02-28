# Hello Net

A simple network demonstrating how to make a SUMO network by hand.

The `hello.edg.xml` and `hello.nod.xml` file defines the network and are modified manually. They are compiled to `hello.net.xml` using the following command:

`netconvert.exe --node-files=hello.nod.xml --edge-files=hello.edg.xml --output-file=hello.net.xml`

The `hello.rou.xml` describes vehicles, routes, and cars/busses on the net (i.e. the demand). This is also created by hand.

The `hello.sumocfg` is connects the other files and can be loaded by sumo using the command `sumo-gui.exe -c hello.sumocfg --demo` or manually in SUMO.
