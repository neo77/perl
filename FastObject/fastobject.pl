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

# class dane
# 	imie
# 	nazwisko
package Fast;
use Data::Dumper;
# FIXME (autoACR): write why are you using Data::Dumper (do you realy need it?)
# --- glowny definiuje co trzeba w przestrzeni nazw odpowiedniej klasy

# const
my %attribs = (imie => 0, nazwisko => 1, wiek => 3); 
my $attribs_size = 3;

# working
my $max_object = 1;
my @object = ();		# poczatkowa wartosc dla speedupa
my @free_list = (0);

#=------
#  new
#=------
#* create new object
# RETURN: blessed object
sub new { 
	print Dumper({"create" => {free_list => \@free_list, max_obj=>$max_object, object => \@object}});
	my $self = (@free_list)?(shift @free_list) : $max_object++;
	print Dumper({"create ($self)" => {free_list => \@free_list, max_obj=>$max_object, object => \@object}});
	return bless \$self, __PACKAGE__;
	
}

#=----------
#  DESTROY
#=----------
#* removing object and set free index
# RETURN: nothing
sub DESTROY {
	my $obj = shift;
	push @free_list, $$obj;
	print Dumper({"destroy ($$obj)" =>{free_list => \@free_list, max_obj=>$max_object, object => \@object}});
}

#=-------
#  imie
#=-------
#* sets imie to object
# RETURN: current value
sub imie {
	($_[1]) ? $object[ ${$_[0]}*5 + 0 ] = $_[1] : $object[ ${$_[0]}*5 + 0 ];
}

package main;
my $obj = new Fast;
my $obj2 = new Fast;
$obj->imie('iza');
$obj2->imie('kop');
print Dumper(\@object);
$obj->imie('tomek');
print Dumper(\@object);
#
# obiekty [ 0..latrr, latrr+1..2*lattr, ] wiec dostep przez index_obiektu*index_atrybutu_z_hasha_atrybutow
# 	free_list (0, 1, 2, 3) lastind 
