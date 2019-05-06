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


set slope_x          [pfload $runname.out.slope_x.silo]
set slope_y          [pfload $runname.out.slope_y.silo]
set mannings         [pfload $runname.out.mannings.silo]
set specific_storage [pfload $runname.out.specific_storage.silo]
set porosity         [pfload $runname.out.porosity.silo]

set mask             [pfload $runname.out.mask.silo]
set top              [pfcomputetop $mask]


for {set i 1} {$i <= 2400} {incr i} {
	set filename [format "%s.out.press.%05d.pfb" $runname $i]
    set pressure [pfload $filename]
    
    set filename [format "%s.out.satur.%05d.pfb" $runname $i]
    set saturation [pfload $filename]

    set subsurface_storage [pfsubsurfacestorage $mask $porosity $pressure $saturation $specific_storage]
    pfsave $subsurface_storage -pfb  "subsurface_storage.$i.pfb"

    set total_subsurface_storage [pfsum $subsurface_storage]

	puts [format "Timestep\t\t %s \t\t %.16e" $i $total_subsurface_storage]

}

