#!/usr/bin/tclsh 
#  This calculates NON-vardz aware subsurface storage from original
#  output press and sat .pfb files want the SUM from each time step
#  just to see if subsurface storage is still changing or
#  has stabilized.

set tcl_precision 17


set runname lbase


#
# Import the ParFlow TCL package
#
lappend auto_path $env(PARFLOW_DIR)/bin 
package require parflow
namespace import Parflow::*

pfset FileVersion 4



for {set i 1} {$i <= 164} {incr i} {
     set filename [format "vdz_subsurfstor.%05d.pfb" $i]
     set vdzsss [pfload $filename]
     set total_subsurface_storage [pfsum $vdzsss]

	puts [format "Timestep\t\t %s \t\t %.16e" $i $total_subsurface_storage]

}

