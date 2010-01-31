#!/usr/bin/perl 
#APos: APosDoc=1.3
#* Name: fasttest.pl
#* Info: 
#* Author: Pawel Guspiel (neo77), <neo77@panth-net.com || pawel.guspiel@hurra.com>
#*
#*
# FIXME (autoACR): update Info field

use strict;
use warnings;

#=------------------------------------------------------------------------ USE, CONSTANTS..

use Data::Dumper;		# FIXME Debug only
use FastObject;			# fast object interface

#=------------------------------------------------------------------------ FUNCTIONS



#=------------------------------------------------------------------------ main()

require capo;	# class
require pracownik;	# class
_internal_class_Dump('capo',1);
_internal_class_Dump('pracownik',1);




