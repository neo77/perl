#!/usr/bin/perl 
#APos: APosDoc=1.1
#* Name: bench.pl
#* 
#* Author: Pawel Guspiel (neo77), <neo77@panth-net.com || pawel.guspiel@hurra.com>
#*
#*

use strict;
use warnings;
#no warnings qw(deprecated);
#=------------------------------------------------------------------------ USE, CONSTANTS..

use FindBin qw/$Bin/;
use lib $Bin."/../../";

use Data::Dumper;
# FIXME (autoACR): write why are you using Data::Dumper (do you realy need it?)


#=------------------------------------------------------------------------ FUNCTIONS

=pod
package APos;
use APos::core::APosObj;
# FIXME (autoACR): write why are you using APos::core::APosObj (do you realy need it?)
use Data::Dumper;
# FIXME (autoACR): write why are you using Data::Dumper (do you realy need it?)

our @ISA = qw(APos::core::APosObj);
#=------
#  new
#=------
#* put_description_here
# RETURN: put_return_value_here
sub new {
	my ($classname, %params) = @_;
	my $self = $classname->SUPER::construct;

	$self->_add_attribs(attributes => { 
			'x' => $params{'x'} || 'x_undef',
			'y' => $params{'y'} || 'y_undef',
			'name' => $params{'name'} || 'name_undef',
			'z' => $params{'z'} || 'z_undef',
			'color' => $params{'color'} || 'color_undef',
			'desc' => $params{'desc'} || 'desc_undef',
	});
	return $self;
}
# TODO (autoACR): update function/group documentation at header (put_description_here)
# TODO (autoACR): update function documentation at header (put_return_value_here)



=cut

=pod
Benchmark: timing 100000 iterations of APos, arrayref, hashref, moose, moose immutable, moose immutable with validate, sitegen (reverse hashes), traditional...
      APos: 1.9636 wallclock secs ( 1.97 usr +  0.00 sys =  1.97 CPU) @ 50761.42/s (n=100000)
  arrayref: 0.574946 wallclock secs ( 0.57 usr +  0.00 sys =  0.57 CPU) @ 175438.60/s (n=100000)
   hashref: 0.592095 wallclock secs ( 0.59 usr +  0.00 sys =  0.59 CPU) @ 169491.53/s (n=100000)
     moose: 33.9228 wallclock secs (33.84 usr +  0.02 sys = 33.86 CPU) @ 2953.34/s (n=100000)
moose immutable: 3.85927 wallclock secs ( 3.85 usr +  0.01 sys =  3.86 CPU) @ 25906.74/s (n=100000)
moose immutable with validate: 6.43499 wallclock secs ( 6.37 usr +  0.01 sys =  6.38 CPU) @ 15673.98/s (n=100000)
sitegen (reverse hashes): 3.71962 wallclock secs ( 3.65 usr +  0.07 sys =  3.72 CPU) @ 26881.72/s (n=100000)
traditional: 2.75828 wallclock secs ( 2.76 usr +  0.00 sys =  2.76 CPU) @ 36231.88/s (n=100000)


=cut
package FastObject;		# my
# --- glowny definiuje co trzeba w przestrzeni nazw odpowiedniej klasy

# const
my %attribs = (x => 0, z => 1, color => 3, name=>4, y=>5); 
my @default = (3, 4, 'green', undef, 6); 
my $attribs_size = 5;

# working
my $max_object = 0;
my @object;		# poczatkowa wartosc dla speedupa
my @free_list;

#=------
#  new
#=------
#* create new object
# RETURN: blessed object
sub new { 
	my ($class,%params) = @_;

	my $self = (@free_list)?(shift @free_list) : $max_object++;
	for my $key (keys %params) {
		#my $k = $attribs{"$key"};
		$object[ $self*$attribs_size + $attribs{"$key"} ] = $params{$key} || $default[$attribs{"$key"}];
	}

	return bless \$self, $_[0];
	
}

#=----------
#  DESTROY
#=----------
#* removing object and set free index
# RETURN: nothing
sub DESTROY {
	push @free_list, ${$_[0]};
}

#=----
#  x
#=----
#* sets x to object
# RETURN: current value
sub x {
	($_[1]) ? $object[ ${$_[0]}*5 + 0 ] = $_[1] : $object[ ${$_[0]}*5 + 0 ];
}
#=----
#  z
#=----
#* sets y to object
# RETURN: current value
sub z {
	($_[1]) ? $object[ ${$_[0]}*5 + 1 ] = $_[1] : $object[ ${$_[0]}*5 + 1 ];
}

#=--------
#  color
#=--------
#* sets color to object
# RETURN: current value
sub color {
	($_[1]) ? $object[ ${$_[0]}*5 + 2 ] = $_[1] : $object[ ${$_[0]}*5 + 2 ];

}

#=-------
#  name
#=-------
#* sets name to object
# RETURN: current value
sub name {
	($_[1]) ? $object[ ${$_[0]}*5 + 3 ] = $_[1] : $object[ ${$_[0]}*5 + 3 ];
}
#=----
#  y
#=----
#* sets y to object
# RETURN: current value
sub y {
	($_[1]) ? $object[ ${$_[0]}*5 + 4 ] = $_[1] : $object[ ${$_[0]}*5 + 4 ];
}

package main;
#=------------------------------------------------------------------------ main()

my %names = (  'name',0, 'arron',1 );


use Benchmark qw(cmpthese timethese timeit timestr :hireswallclock);	# for benchmark
cmpthese( timethese( 100_000, {
	'hash' => sub {
		my %hash = ('nowa'=>'45');
		$hash{'amar'} = 5;
		$hash{'nowa'} = 7;
		my $a = $hash{'amar'};
		my $b = $hash{'nowa'};
	},
	'hashref' => sub {
		my $hash = {'nowa'=>'45'};
		$hash->{'amar'} = 5;
		$hash->{'nowa'} = 7;
		my $a = $hash->{'amar'};
		my $b = $hash->{'nowa'};
	},
	'array' => sub {
		my $hash = [ 1,undef];
		$hash->[$names{'name'}] = 1;

		$hash->[$names{'arron'}] = 7;

		my $a = $hash->[$names{'name'}];
		my $b = $hash->[$names{'arron'}];
	},
	'FastObject' => sub {
		my $obj = FastObject->new( x=>11, y=>22, name=>'pkt');
		$obj->x(33);
		$obj->z(1);
		$obj->color('gray');
		my $z = $obj->z;
		my $color = $obj->color;
		my $name = $obj->name;
	}
}));

__END__
	'APos' => sub {
		my $obj = APos->new( x=>11, y=>22, name=>'pkt');
		$obj->x(33);
		$obj->z(1);
		$obj->color('gray');
		my $z = $obj->z;
		my $color = $obj->color;
		my $name = $obj->name;
	}




