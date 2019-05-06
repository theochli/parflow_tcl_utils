#!/usr/bin/tclsh 
#  This calculates NON-vardz aware subsurface storage from original
#  output press and sat .pfb files 
#  and outputs a NON-vardz aware subsurface storage pfb file for
#  each timestep. These pfbs are then read into a fortran 
#  program that multiplies each layer by the appropriate 
#  scaling factor 

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


for {set i 1} {$i <= 164} {incr i} {
	set filename [format "%s.out.press.%05d.pfb" $runname $i]
    set pressure [pfload $filename]
    
    set filename [format "%s.out.satur.%05d.pfb" $runname $i]
    set saturation [pfload $filename]

    set subsurface_storage [pfsubsurfacestorage $mask $porosity $pressure $saturation $specific_storage]
    pfsave $subsurface_storage -pfb [format "subsurface_storage.%05d.pfb" $i]

   }

