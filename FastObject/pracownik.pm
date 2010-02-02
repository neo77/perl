#!/usr/bin/perl
#APos: APosDoc=1.3
#* Name: ::home::neo77::workspace::FastObject::osoba
#* Info: 
#* Author: Pawel Guspiel (neo77), <neo77@panth-net.com || pawel.guspiel@hurra.com>
#*
#*
# FIXME (autoACR): update Info field
package pracownik;

use strict;
use warnings;


#=------------------------------------------------------------------------ USE, CONSTANTS..

use FastObject;
# FIXME (autoACR): write why are you using FastObject (do you realy need it?)

our $VERSION = 1.0;


#=------------------------------------------------------------------------ CONSTRUCTOR
# only for constructor and destructor (if exists)

use osoba;
# FIXME (autoACR): write why are you using osoba (do you realy need it?)
class {
	inherite 'osoba';
	has 'stanowisko';
	has 'placa';
};


#=------------------------------------------------------------------------ PRIVATE FUNCTIONS
# start every private function with '_' sign


#=------------------------------------------------------------------------ CLASS FUNCTIONS
# start every class function with Capital letter


#=------------------------------------------------------------------------ PUBLIC FUNCTIONS
#


1;

