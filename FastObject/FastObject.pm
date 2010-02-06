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

#use Data::Dumper; # _internal_class_Dump
#=------------------------------------------------------------------------ USE, CONSTANTS..

our $VERSION = 1.0;

use base 'Exporter';	# exporting functions

our @EXPORT = qw(class has _internal_class_Dump inherite);
our $_processed_class = '';		# currently procesed class
my %_class_code;				# class code hash (class definition for each class

#=------------------------------------------------------------------------ PUBLIC FUNCTIONS (CLASS)
#

#=--------
#  class
#=--------
#* class definition
# RETURN: true
sub class(&;$) {
	my ($p_code) = @_;
	my $classname = $_processed_class || caller;

	#print "---> \%$classname (".(caller).")\n";
	# create package globals
	unless ($_processed_class)  {
		#print "Creating $classname (globals)\n";
		eval <<EOE;
			package $classname;
			use strict;
			# --- package const
			our \%attribs;
			our \$attribs_size = 0;
			our \$max_objects = 1;
			our \@objects = 128;
			our \@free_list;
			our \%default_param_values;

			sub new {
				my (\$class,\%params) = \@_;
			
				my \$self = (\@$classname\::free_list) ? ( shift \@$classname\::free_list ) : \$$classname\::max_objects++;
				for my \$key (keys \%attribs) {
					\$$classname\::objects[ \$self*\$$classname\::attribs_size + \$$classname\::attribs{"\$key"} ] = \$params{\$key} || \$$classname\::default_param_values{"\$key"};
				}

				return bless \\\$self, \$class;
			}
			sub DESTROY {
				push \@$classname\::free_list, \${\$_[0]};
			}
EOE
		#print "_class_code{$classname} = p_code\n";
		$_class_code{"$classname"} = $p_code;
#				for my \$key (keys \%params) {
#					\$$classname\::objects[ \$self*\$$classname\::attribs_size + \$$classname\::attribs{"\$key"} ] = \$params{\$key} || \$$classname\::default_param_values{"\$key"};
#				}

	}

	#print "runs _class_code ($classname)\n";
	&{$_class_code{"$classname"}};

	$_processed_class = undef if $_processed_class eq $classname;
	# create new
	# create accessors
}

#=------
#  has
#=------
#* add attribs to class
# RETURN: put_return_value_here
sub has($;@) {
	my ($p_attrib_name, %params) = @_;

	my $p_default = $params{'default'};

	my $classname = $_processed_class || caller;
	##print "evaluating: \$$classname\::attribs{$p_attrib_name} = \$$classname\::attribs_size++; (".(caller).")\n";
#  inherite
	eval <<EOE
		\$$classname\::attribs{$p_attrib_name} = \$$classname\::attribs_size++;;
			\$$classname\::default_param_values{$p_attrib_name} = \$p_default;
		package $classname;
		# inherite check
		sub $p_attrib_name {
			(\@_>1)?(\$$classname\::objects[ \${\$_[0]}*\$$classname\::attribs_size + \$$classname\::attribs{"$p_attrib_name"} ] = \$_[1]):
				\$$classname\::objects[ \${\$_[0]}*\$$classname\::attribs_size + \$$classname\::attribs{"$p_attrib_name"} ];
		};
EOE
			#return \$$classname\::objects[ \$\$self*\$$classname\::attribs_size + \$$classname\::attribs{"$p_attrib_name"} ];
}
# TODO (autoACR): update function documentation at header (put_return_value_here)

#=-----------
#  inherite
#=-----------
#* inheriting support
# RETURN: put_return_value_here
sub inherite {
	my $p_parent_class = shift;
	
	my $classname = caller;
	#print "Inheriting from $p_parent_class ($classname)\n";
	# create package globals
	eval "package $classname; use base '$p_parent_class' ";

	$_processed_class = $classname unless $_processed_class;
	#print "runs _class_code ($p_parent_class)\n";
	&{$_class_code{"$p_parent_class"}};
}
# TODO (autoACR): update function documentation at header (put_return_value_here)

=pod
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
=cut 
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

# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 87)
# TODO (autoACR): update function documentation at header (put_return_value_here)
# FIXME (autoACR): PERL Syntax error sub not closed or { "#" } problem! (start parsing on: 87)
# TODO (autoACR): update function documentation at header (put_return_value_here)
