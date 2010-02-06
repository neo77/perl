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

use capo;	# class
use osoba;
# FIXME (autoACR): write why are you using osoba (do you realy need it?)


my $obj = new capo;
my $obj2 = new capo;
my $obj3 = new capo;
print $obj->pracownicy;
$obj2->pracownicy(3);
print $obj->pracownicy;
_internal_class_Dump('capo',1);


