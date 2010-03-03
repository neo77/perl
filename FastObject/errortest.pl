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

#=------
#  top
#=------
#* put_description_here
# RETURN: put_return_value_here
sub top {
    my ($self,$val) = @_;
    if (defined($val)) {
        return $self->SUPER::top($val*2);
    } else {
        return $self->SUPER::top;
    }
}
# TODO (autoACR): update function/group documentation at header (put_description_here)
# TODO (autoACR): update function documentation at header (put_return_value_here)

package main;

my $self =  new AnyOther;
$self->error('cut');
$self->top('4');
print "talk to me: ".$self->error."\n";
print "talk to me: ".$self->top."\n";

