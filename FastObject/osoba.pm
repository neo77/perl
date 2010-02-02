#!/usr/bin/perl
#APos: APosDoc=1.3
#* Name: ::home::neo77::workspace::FastObject::osoba
#* Info: 
#* Author: Pawel Guspiel (neo77), <neo77@panth-net.com || pawel.guspiel@hurra.com>
#*
#*
# FIXME (autoACR): update Info field
package osoba;

use strict;
use warnings;


#=------------------------------------------------------------------------ USE, CONSTANTS..

use FastObject;
# FIXME (autoACR): write why are you using FastObject (do you realy need it?)

our $VERSION = 1.0;


#=------------------------------------------------------------------------ CONSTRUCTOR
# only for constructor and destructor (if exists)

class {
	has 'imie';
	has 'nazwisko';
	has 'wiek';
};


#=------------------------------------------------------------------------ PRIVATE FUNCTIONS
# start every private function with '_' sign


#=------------------------------------------------------------------------ CLASS FUNCTIONS
# start every class function with Capital letter


#=------------------------------------------------------------------------ PUBLIC FUNCTIONS
#

#=----------
#  getinfo
#=----------
#* put_description_here
# RETURN: put_return_value_here
sub getinfo {
	print "Osoba mowi papa\n";
}
# TODO (autoACR): update function/group documentation at header (put_description_here)
# TODO (autoACR): update function documentation at header (put_return_value_here)

1;

