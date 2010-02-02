#!/usr/bin/perl
#APos: APosDoc=1.3
#* Name: ::home::neo77::workspace::FastObject::FastObject
#* Info: 
#* Author: Pawel Guspiel (neo77), <neo77@panth-net.com || pawel.guspiel@hurra.com>
#*
#*
# FIXME (autoACR): update Info field
package FastObject;

use strict;
use warnings;

use Data::Dumper; # _internal_class_Dump
#=------------------------------------------------------------------------ USE, CONSTANTS..

our $VERSION = 1.0;

use base 'Exporter';	# exporting functions

our @EXPORT = qw(class has _internal_class_Dump inherite);
our @INH_CLASS = ();
our $_INH_CLASS = '';
my %has_code;

#=------------------------------------------------------------------------ PUBLIC FUNCTIONS (CLASS)
#

#=--------
#  class
#=--------
#* class definition
# RETURN: true
sub class(&;$) {
	my ($p_code) = @_;
	my $classname = $_INH_CLASS || caller;

	print "---> \%$classname (".(caller).")\n";
	# create package globals
	unless ($_INH_CLASS)  {
		print "Creating $classname (globals)\n";
		eval <<EOE;
			package $classname;
			use strict;
			# --- package const
			our \%attribs;
			our \$attribs_size = 0;
			our \$max_objects = 1;
			our \@objects = ();
			our \@free_list = (0);

			sub new {
				my (\$class,\%params) = \@_;
			
				my \$self = (\@free_list) ? ( shift \@free_list ) : \$max_objects++;

				return bless \\\$self, \$_[0];
			}
			sub DESTROY {
				push \@free_list, \${\$_[0]};
			}
EOE
		print "has_code{$classname} = p_code\n";
		$has_code{"$classname"} = $p_code;

=pod
				for my $key (keys %params) {
					$objects[ $self*$attribs_size + $attribs{"$key"} ] = $params{$key} || $default[$attribs{"$key"}];
				}
				for my $key (keys %params) {
	#				$object[ $self*$attribs_size + $attribs{"$key"} ] = $params{$key} || $default[$attribs{"$key"}];
	#			}
		{"$classname\::new"} = sub { 
				my ($class,%params) = @_;

				my $self = (@{"$classname\::free_list"})?(shift @{"$classname\::free_list"}) : ${"$classname\::max_object"}++;
	#			for my $key (keys %params) {
	#				$object[ $self*$attribs_size + $attribs{"$key"} ] = $params{$key} || $default[$attribs{"$key"}];
	#			}

				return bless \$self, $_[0];
				
		};

		#	sub DESTROY {
		#		push \@free_list, \${\$_[0]};
		#	}
=cut
}

	print "runs has_code ($classname)\n";
	&{$has_code{"$classname"}};

	$_INH_CLASS = undef if $_INH_CLASS eq $classname;
	# create new
	# create accessors
}

#=------
#  has
#=------
#* add attribs to class
# RETURN: put_return_value_here
sub has($;$$) {
	my ($attrib_name, $attrib_default, $attrib_type) = @_;

	my $classname = $_INH_CLASS || caller;
	print "evaluating: \$$classname\::attribs{$attrib_name} = \$$classname\::attribs_size++; (".(caller).")\n";
	eval "\$$classname\::attribs{$attrib_name} = \$$classname\::attribs_size++;"
}
# TODO (autoACR): update function documentation at header (put_return_value_here)

#=-----------
#  inherite
#=-----------
#* inheriting support
# RETURN: put_return_value_here
sub inherite {
	my $inherited = shift;
	
	my $classname = caller;
	print "Inheriting from $inherited ($classname)\n";
	# create package globals
	eval "package $classname; use base '$inherited' ";

	$_INH_CLASS = $classname unless $_INH_CLASS;
	print "runs has_code ($inherited)\n";
	&{$has_code{"$inherited"}};
}
# TODO (autoACR): update function documentation at header (put_return_value_here)


#=-----------------------
#  _internal_class_Dump
#=-----------------------
#* make class dump (internal)
# RETURN: nothing.. just prints info
sub _internal_class_Dump($;$) {
	my ($classname, $extend) = @_;
	print Dumper({ 
		attribs 		=> eval "\\\%$classname\::attribs",
		attribs_size 	=> eval "\$$classname\::attribs_size",
		
	});
	if ($extend) {
		print Dumper({ 
			max_objects => eval "\$$classname\::max_objects",
			free_list 	=> eval "\\\@$classname\::free_list",
			objects 	=> eval "\\\@$classname\::objects",
		});
	}
}

#=------------------------------------------------------------------------ PUBLIC FUNCTIONS (OBJECT)






# class Mas {
# 	has cos
# 	has wos
# 	has klos
# 	inherit => use base,  a w ramach jednego class inne class dodaja has i tyle
# 	inherited dupa
# 	i na koncu w obrebie danego pakietu sa tworzone funkcje
# }

# package dupa
# class dupa {
# 	has ktos
# }

# has doklada do attributes w danym pakiecie info
#



1;
__END__
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

# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 34)
