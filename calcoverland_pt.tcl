
# This script calculates the overland flow at a point for each
# time step using Manning's equation (see manual p 75)



lappend auto_path $env(PARFLOW_DIR)/bin
package require parflow
namespace import Parflow::*


set tcl_precision 16
set runname lbase


#Set the location
set Xloc 	82
set Yloc 	13
set Zloc 	11 
#This should be a z location on the surface of your domain
#Set the grid dimension and Mannings roughness coefficient
set dx 	        5.0
set n 		5e-5
#Get the slope at the point
set slopex	[pfload "slopex.pfb"]
set slopey	[pfload "slopey.pfb"]
set sx1 	[pfgetelt $slopex $Xloc $Yloc 0]
set sy1 	[pfgetelt $slopey $Xloc $Yloc 0]
set S 		[expr ($sx1**2+$sy1**2)**0.5]
#Get the pressure at the point
#set 		press [pfload runname.out.press.00001.pfb]
#set P 		[pfgetelt $press $Xloc $Yloc $Zloc]

#If the pressure is less than zero set to zero
for {set i 1 } {$i <= 100 } {incr i} {

        set filename [format "%s.out.press.%05d.pfb" $runname $i]
	set press [pfload $filename]
	set P [pfgetelt $press $Xloc $Yloc $Zloc]
	
	if {$P < 0} { set P 0}
	set QT [expr ($dx/$n)*($S**0.5)*($P**(5./3.))]
	puts [format "%s \t %.16e" $i $QT]

}

