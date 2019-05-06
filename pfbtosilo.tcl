lappend auto_path $env(PARFLOW_DIR)/bin 
package require parflow
namespace import Parflow::*


set tcl_precision 16
set runname lbase

for {set i 0 } {$i <= 440} {incr i 10} {

	set filename [format "lbase.out.press.%05d.pfb"  $i]
	set press [pfload $filename]
	pfsave $press  -silo "press.$i.silo"


	set filename [format "lbase.out.satur.%05d.pfb"  $i]
	set satur [pfload $filename]
	pfsave $satur  -silo "satur.$i.silo"

}
