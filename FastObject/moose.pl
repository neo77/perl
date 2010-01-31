#!/usr/bin/env perl

use warnings;
use strict;
use FindBin qw/$Bin/;
use lib $Bin."/../../";

use Benchmark qw(cmpthese timethese timeit timestr :hireswallclock);

package WithMoose;
use Moose;

has x => ( is => 'rw', required => 1 );
has y => ( is => 'rw', required => 1 );
has z => ( is => 'rw', default  => 0 );
has color => ( is => 'rw', builder => '_build_color' );
has name  => ( is => 'ro' );
has desc  => ( is => 'ro' );

sub _build_color { return ('red', 'green', 'blue')[int rand 3]; }


package WithMooseIm;
use Moose;

has x => ( is => 'rw', required => 1 );
has y => ( is => 'rw', required => 1 );
has z => ( is => 'rw', default  => 0 );
has color => ( is => 'rw', builder => '_build_color' );
has name  => ( is => 'ro' );
has desc  => ( is => 'ro' );

sub _build_color { return ('red', 'green', 'blue')[int rand 3]; }

__PACKAGE__->meta->make_immutable;


package WithMooseImVal;
use Moose;

has x => ( is => 'rw', isa => 'Int', required => 1 );
has y => ( is => 'rw', isa => 'Int', required => 1 );
has z => ( is => 'rw', isa => 'Int', default  => 0 );
has color => ( is => 'rw', isa => 'Str', builder => '_build_color' );
has name  => ( is => 'ro', isa => 'Str' );
has desc  => ( is => 'ro', isa => 'Str' );

sub _build_color { return ('red', 'green', 'blue')[int rand 3]; }

__PACKAGE__->meta->make_immutable;


package Sitegen;
my ( %x, %y, %z, %color, %name, %desc );
sub new {
    my ( $class, %p ) = @_;
    my $rs   = \do{ my $scalar };
    my $self = bless( $rs, $class );

    $x{$self}     = $p{'x'} or die;
    $y{$self}     = $p{'y'} or die;
    $z{$self}     = ( $p{'z'} or 0 );
    $color{$self} = ( $p{'color'} or _build_color() );
    $name{$self}  = $p{'name'} if $p{'name'};
    $desc{$self}  = $p{'desc'} if $p{'desc'};

    return $self;
}
sub _build_color { return ('red', 'green', 'blue')[int rand 3]; }
sub set_x {
    my $self = shift;
    $x{$self} = shift;
}
sub get_x {
    my $self = shift;
    return $x{$self};
}
sub set_y {
    my $self = shift;
    $y{$self} = shift;
}
sub get_y {
    my $self = shift;
    return $y{$self};
}
sub set_z {
    my $self = shift;
    $z{$self} = shift;
}
sub get_z {
    my $self = shift;
    return $z{$self};
}
sub set_color {
    my $self = shift;
    $color{$self} = shift;
}
sub get_color {
    my $self = shift;
    return $color{$self};
}
sub get_name {
    my $self = shift;
    return $name{$self};
}
sub get_desc {
    my $self = shift;
    return $desc{$self};
}


package Standard;
sub new {
    my ( $class, %p ) = @_;
    my $self;
    $self->{'x'}     = $p{'x'} or die;
    $self->{'y'}     = $p{'y'} or die;
    $self->{'z'}     = ( $p{'z'} or 0 );
    $self->{'color'} = ( $p{'color'} or _build_color() );
    $self->{'name'}  = $p{'name'} if $p{'name'};
    $self->{'desc'}  = $p{'desc'} if $p{'desc'};

    bless $self, $class;
    return $self;
}
sub _build_color { return ('red', 'green', 'blue')[int rand 3]; }
sub set_x {
    my $self = shift;
    $self->{'x'} = shift;
}
sub get_x {
    my $self = shift;
    return $self->{''};
}
sub set_y {
    my $self = shift;
    $self->{'y'} = shift;
}
sub get_y {
    my $self = shift;
    return $self->{'y'};
}
sub set_z {
    my $self = shift;
    $self->{'z'} = shift;
}
sub get_z {
    my $self = shift;
    return $self->{'z'};
}
sub set_color {
    my $self = shift;
    $self->{'color'} = shift;
}
sub get_color {
    my $self = shift;
    return $self->{'color'};
}
sub get_name {
    my $self = shift;
    return $self->{'name'};
}
sub get_desc {
    my $self = shift;
    return $self->{'desc'};
}
#=---------------------------------------------------- APos

package APos;

use Data::Dumper;
use APos::core::APosObj;

has 'x';
has 'y'; 
has 'z'; 
has 'name';
has 'color';
has 'desc';

#=---------------------------------------------------- main

package main;


cmpthese( timethese( 100_000, {

    'moose' => sub {
        my $obj = WithMoose->new( x=>11, y=>22, name=>'pkt' );
        $obj->x(33);
        $obj->z(1);
        $obj->color('gray');
        my $z = $obj->z;
        my $color = $obj->color;
        my $name  = $obj->name;
    },

    'moose immutable' => sub {
        my $obj = WithMooseIm->new( x=>11, y=>22, name=>'pkt' );
        $obj->x(33);
        $obj->z(1);
        $obj->color('gray');
        my $z = $obj->z;
        my $color = $obj->color;
        my $name  = $obj->name;
    },

    'moose immutable with validate' => sub {
        my $obj = WithMooseImVal->new( x=>11, y=>22, name=>'pkt' );
        $obj->x(33);
        $obj->z(1);
        $obj->color('gray');
        my $z = $obj->z;
        my $color = $obj->color;
        my $name  = $obj->name;
    },

    'sitegen (reverse hashes)' => sub {
        my $obj = Sitegen->new( x=>11, y=>22, name=>'pkt' );
        $obj->set_x(33);
        $obj->set_z(1);
        $obj->set_color('gray');
        my $z = $obj->get_z;
        my $color = $obj->get_color;
        my $name  = $obj->get_name;
    },

    'traditional' => sub {
        my $obj = Standard->new( x=>11, y=>22, name=>'pkt' );
        $obj->set_x(33);
        $obj->set_z(1);
        $obj->set_color('gray');
        my $z = $obj->get_z;
        my $color = $obj->get_color;
        my $name  = $obj->get_name;
    },

    'hashref' => sub {
        my $obj = { x=>11, y=>22, name=>'pkt' };
        $obj->{'x'} = 33;
        $obj->{'z'} = 1;
        $obj->{'color'} = 'gray';
        my $z = $obj->{'z'};
        my $color = $obj->{'color'};
        my $name  = $obj->{'name'};
    },
    'arrayref' => sub {
        my $obj = [ x=>11, y=>22, name=>'pkt' ];
        $obj->[1] = 33;
        $obj->[3] = 1;
        $obj->[5] = 'gray';
        my $z = $obj->[3];
        my $color = $obj->[5];
        my $name  = $obj->[3];
    },

	'APos' => sub {
		my $obj = APos->construct( x=>11, y=>22, name=>'pkt');
		$obj->x(33);
		$obj->z(5);
		$obj->color('gray');
		my $z = $obj->z;
		my $color = $obj->color;
		my $name = $obj->name;
	}

}));

