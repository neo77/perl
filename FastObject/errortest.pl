#!/usr/bin/perl 
#APos: APosDoc=1.3
#* Name: fastobject.pl
#* Info: 
#* Author: Pawel Guspiel (neo77), <neo77@panth-net.com || pawel.guspiel@hurra.com>
#*
#*
# FIXME (autoACR): update Info field

use strict;
use warnings;

#=------------------------------------------------------------------------ USE, CONSTANTS..

use FindBin qw/$Bin/;
use lib $Bin."/../../../";

use Data::Dumper;		# FIXME Debug only


#=------------------------------------------------------------------------ FUNCTIONS



#=------------------------------------------------------------------------ main()



package AnyOther;

use FastObject;
# FIXME (autoACR): write why are you using FastObject (do you realy need it?)

class {
    inherite "FastObject::Error";
    has 'top';
};

package main;

my $self =  new AnyOther;
$self->error('cut');
print "talk to me: ".$self->error."\n";

