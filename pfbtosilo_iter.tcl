lappend auto_path $env(PARFLOW_DIR)/bin 
package require parflow
namespace import Parflow::*


set tcl_precision 16
set runname slopes_only

for {set i 78849} {$i <= 87610} {incr i 1} {

	set filename [format "%s.out.press.%05d.pfb" $runname $i]
	set press [pfload $filename]
	pfsave $press  -silo "press.$i.silo"


	set filename [format "%s.out.satur.%05d.pfb" $runname $i]
	set satur [pfload $filename]
	pfsave $satur  -silo "satur.$i.silo"

}
