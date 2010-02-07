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


my $obj = new capo(pracownicy=>'params');
my $obj2 = new capo;
my $obj3 = new capo;
print $obj2->pracownicy;
$obj2->pracownicy(3);
print $obj2->pracownicy;
_internal_class_Dump('capo',1);

package FastObject;
use Data::Dumper;
# FIXME (autoACR): write why are you using Data::Dumper (do you realy need it?)
#=-----------------------
#  _internal_class_Dump
#=-----------------------
#* make class dump (internal)
# RETURN: nothing.. just prints info
sub _internal_class_Dump($;$) {
	my ($p_classname, $p_extend) = @_;
	print Dumper({ 
		attribs 		=> eval "\\\%$p_classname\::attribs",
		attribs_size 	=> eval "\$$p_classname\::attribs_size",
		
	});
	if ($p_extend) {
		print Dumper({ 
			max_objects => eval "\$$p_classname\::max_objects",
			free_list 	=> eval "\\\@$p_classname\::free_list",
			objects 	=> eval "\\\@$p_classname\::objects",
		});
	}
}

