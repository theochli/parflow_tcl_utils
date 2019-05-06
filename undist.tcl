

set tcl_precision 17

set runname lbase
set verbose 1
#
# Import the ParFlow TCL package
#
lappend auto_path $env(PARFLOW_DIR)/bin 
package require parflow
namespace import Parflow::*

pfset FileVersion 4

pfset Process.Topology.P        		2
pfset Process.Topology.Q        		1
pfset Process.Topology.R        		1

pfundist $runname
pfundist slopex.pfb
pfundist slopey.pfb
#pfundist mannings.pfb
pfundist permeability-spinup.pfb
pfundist indicator.pfb
