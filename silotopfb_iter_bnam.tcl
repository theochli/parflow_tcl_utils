

lappend auto_path $env(PARFLOW_DIR)/bin
package require parflow
namespace import Parflow::*


set tcl_precision 16

set fbasenam [lindex $argv 0]

for {set i 0 } {$i <= 19} {incr i 1} {
	set silo [pfload $fbasenam.$i.silo]
	pfsave $silo -pfb [format "$fbasenam.$i.pfb"]

}
