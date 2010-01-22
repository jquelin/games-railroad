use 5.010;
use strict;
use warnings;

package Games::RailRoad::Vector;
# ABSTRACT: an opaque vector class.

use Readonly;
use base qw{ Class::Accessor::Fast };
__PACKAGE__->mk_accessors( qw{ x y } );

use overload
	'='   => \&copy,
	'+'   => \&_add,
	'-'   => \&_substract,
	'neg' => \&_invert,
	'+='  => \&_add_inplace,
    '-='  => \&_substract_inplace,
    '<=>' => \&_compare,
	'""'  => \&as_string;

Readonly my %coords2dir => (
    '(-1,-1)' => 'nw',
    '(-1,0)'  => 'w',
    '(-1,1)'  => 'sw',
    '(0,-1)'  => 'n',
    '(0,1)'   => 's',
    '(1,-1)'  => 'ne',
    '(1,0)'   => 'e',
    '(1,1)'   => 'se',
);
Readonly my %dir2coords => (
    'nw' => [-1,-1],
    'w'  => [-1, 0],
    'sw' => [-1, 1],
    'n'  => [ 0,-1],
    's'  => [ 0, 1],
    'ne' => [ 1,-1],
    'e'  => [ 1, 0],
    'se' => [ 1, 1],
);
 

# -- CONSTRUCTORS

#
# my $vec = GR::Vector->new( $x,$y );
#
# Create a new vector. The arguments are a couple of integer
# representing the x and y coordinates.
#
sub new {
	my $pkg = shift;

    # regular GRV object
    my $self = { x=>$_[0], y=>$_[1] };
    bless $self, $pkg;
	return $self;
}


#
# my $vec = GR::Vector->new_dir( $dir );
#
# Create a new vector, from a given direction. The recognized directions
# are C<e>, C<n>, C<ne>, C<nw>, C<s>, C<se>, C<sw>, C<w>.
#
sub new_dir {
	my ($pkg, $dir) = @_;

    return $pkg->new( @{ $dir2coords{$dir} } );
}


#
# my $vec = $v->copy;
#
# Return a new GRV object, which has the same dimensions and coordinates
# as $v.
#
sub copy {
    my $vec = shift;
    return bless {%$vec}, ref $vec;
}


# -- PUBLIC METHODS

#- accessors

#
# my $str = $vec->as_string;
# my $str = "$vec";
#
# Return the stringified form of $vec. For instance, a vector might look
# like "(1,2)".
#
sub as_string {
	my $self = shift;
	return '(' . $self->x . ',' . $self->y . ')';
}


#
# my $str = $vec->as_dir;
#
# Return the cardinal direction (n, sw, etc.) of $vec if it's a unit
# vector (ok, (1,1) is not a unit vector but you see my point).
#
sub as_dir {
    my $self = shift;
    return $coords2dir{"$self"};
}


# -- PRIVATE METHODS

#- math ops

#
# my $vec = $v1->_add($v2);
# my $vec = $v1 + $v2;
#
# Return a new GRV object, which is the result of $v1 plus $v2.
#
sub _add {
	my ($v1, $v2) = @_;
    my $rv = ref($v1)->new( {x=>0, y=>0} );
    $rv->x( $v1->x + $v2->x );
    $rv->y( $v1->y + $v2->y );
	return $rv;
}


#
# my $vec = $v1->_substract($v2);
# my $vec = $v1 - $v2;
#
# Return a new GRV object, which is the result of $v1 minus $v2.
#
sub _substract {
	my ($v1, $v2) = @_;
    my $rv = ref($v1)->new( {x=>0, y=>0} );
    $rv->x( $v1->x - $v2->x );
    $rv->y( $v1->y - $v2->y );
	return $rv;
}


 
#
# my $v2 = $v1->_invert;
# my $v2 = -$v1;
#
# Subtract $v1 from the origin. Effectively, gives the inverse of the
# original vector. The new vector is the same distance from the origin,
# in the opposite direction.
#
sub _invert {
    my ($v1) = @_;
    my $rv = ref($v1)->new( {x=>0, y=>0} );
    $rv->x( - $v1->x );
    $rv->y( - $v1->y );
	return $rv;
}


#- inplace math ops

#
# $v1->_add_inplace($v2);
# $v1 += $v2;
#
#
sub _add_inplace {
    my ($v1, $v2) = @_;
    $v1->x( $v1->x + $v2->x );
    $v1->y( $v1->y + $v2->y );
	return $v1;
}


#
# $v1->_substract_inplace($v2);
# $v1 -= $v2;
#
# Substract $v2 to $v1, and stores the result back into $v1.
#
sub _substract_inplace {
    my ($v1, $v2) = @_;
    $v1->x( $v1->x - $v2->x );
    $v1->y( $v1->y - $v2->y );
	return $v1;
}


#- comparison

#
# my $bool = $v1->_compare($v2);
# my $bool = $v1 <=> $v2;
#
# Check whether the vectors both point at the same spot. Return 0 if they
# do, 1 if they don't.
#
sub _compare {
    my ($v1, $v2) = @_;
    return 1 if $v1->x != $v2->x;
    return 1 if $v1->y != $v2->y;
    return 0;
}


1;
__END__


=head1 SYNOPSIS

    my $v1 = Games::RailRoad::Vector->new(...);



=head1 DESCRIPTION

This class abstracts basic vector manipulation. It lets you pass around
one argument to your functions, do vector arithmetic and various string
representation.



=head1 CONSTRUCTORS

=head2 my $vec = GR::Vector->new( $x, $y );

Create a new vector. The arguments are the x and y coordinates.



=head2 my $vec = GR::Vector->new_dir( $dir );

Create a new vector, from a given direction. The recognized directions
are C<e>, C<n>, C<ne>, C<nw>, C<s>, C<se>, C<sw>, C<w>.



=head2 my $vec = $v->copy;

Return a new GRV object, which has the same coordinates as $v.



=head1 PUBLIC METHODS

=head2 my $str = $vec->as_string;

Return the stringified form of C<$vec>. For instance, a Befunge vector
might look like C<(1,2)>.

This method is also applied to stringification, ie when one forces
string context (C<"$vec">).



=head2 my $str = $vec->as_dir;

Return the cardinal direction (n, sw, etc.) of $vec if it's a unit
vector (ok, (1,1) is not a unit vector but you see my point).



=head1 MATHEMATICAL OPERATIONS

=head2 Standard operations

One can do some maths on the vectors. Addition and substraction work as
expected:

    my $v = $v1 + $v2;
    my $v = $v1 - $v2;

Either operation return a new GRV object, which is the result of C<$v1>
plus / minus C<$v2>.

The inversion is also supported:
    my $v2 = -$v1;

will subtracts C<$v1> from the origin, and effectively, gives the
inverse of the original vector. The new vector is the same distance from
the origin, in the opposite direction.



=head2 Inplace operations

GRV objects also supports inplace mathematical operations:

    $v1 += $v2;
    $v1 -= $v2;

effectively adds / substracts C<$v2> to / from C<$v1>, and stores the
result back into C<$v1>.


=head2 Comparison

Finally, GRV objects can be tested for equality, ie whether two vectors
both point at the same spot.

    print "same"   if $v1 == $v2;
    print "differ" if $v1 != $v2;



