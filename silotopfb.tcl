# This loads in silo files (which if the run was done on multiple
# processors will have many files) and saves them as pfb files
# This should be run from the run directory. (not the .out dir)

# To close the water balance, need overlandflowsum and evaptranssum
# these are only output as silo files.

# Here I am testing on a run that did not have CLM, so no evap-transsum
# (use subsurface storage for testing purposes). After converting
# to pfb, use Fortran loop to multiply each layer by its dz scale.



lappend auto_path $env(PARFLOW_DIR)/bin 
package require parflow
namespace import Parflow::*


set tcl_precision 16
set runname lbase

set silo1          [pfload $runname.out.slope_x.silo]
pfsave $silo1 -pfb [format "%s.out.slope_x.pfb" $runname ]

set silo1          [pfload $runname.out.slope_y.silo]
pfsave $silo1 -pfb [format "%s.out.slope_y.pfb" $runname ]

set silo1         [pfload $runname.out.mannings.silo]
pfsave $silo1 -pfb [format "%s.out.mannings.pfb" $runname ]

set silo1 [pfload $runname.out.specific_storage.silo]
pfsave $silo1 -pfb [format "%s.out.specific_storage.pfb" $runname ]

set silo1         [pfload $runname.out.porosity.silo]
pfsave $silo1 -pfb [format "%s.out.porosity.pfb" $runname ]

set silo1            [pfload $runname.out.mask.silo]
pfsave $silo1 -pfb [format "%s.out.mask.pfb" $runname ]

