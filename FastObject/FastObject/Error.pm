#!/usr/bin/perl
#APos: APosDoc=1.3
#* Name: FastObject::Error
#* Info: Error extension for fastobject
#* Author: Pawel Guspiel (neo77), <neo77@panth-net.com || pawel.guspiel@hurra.com>
#*
#*
package FastObject::Error;

use strict;
use warnings;


#=------------------------------------------------------------------------ USE, CONSTANTS..

use FastObject 1.0;     # FastObject Main Packete

our $VERSION = 1.0;

#DBG>use Data::Dumper;	# FIXME Debug only
# --- dbg ---
#%::DEBUG_MOD = (
#);
#require Liban::Debug::APDebug;

#=------------------------------------------------------------------------ CONSTRUCTOR
# only for constructor and destructor (if exists)

class {
    has 'error';
}

#=------------------------------------------------------------------------ PRIVATE FUNCTIONS
# start every private function with '_' sign


#=------------------------------------------------------------------------ CLASS FUNCTIONS
# start every class function with Capital letter


#=------------------------------------------------------------------------ PUBLIC FUNCTIONS
#

#=--------
#  error
#=--------
#* put_description_here
# RETURN: put_return_value_here
sub error {
    
}
# TODO (autoACR): update function/group documentation at header (put_description_here)
# TODO (autoACR): update function documentation at header (put_return_value_here)

1;

