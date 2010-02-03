use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch;
# ABSTRACT: a node object with three branches

use Moose;
use MooseX::Has::Sugar;
use MooseX::SemiAffordanceAccessor;

extends qw{ Games::RailRoad::Node };

use Games::RailRoad::Vector;


# -- attributes
has _switch => ( rw, isa=>'Int' );


# -- public methods

sub draw {
    my ($self, $canvas, $tilelen) = @_;
    $self->SUPER::draw($canvas, $tilelen);

    my $pos = $self->position;
    my $dir = $self->_sw_exits->[ $self->_switch ];
    my $vec = Games::RailRoad::Vector->new_dir($dir);
    my $x = $tilelen * ( $pos->posx + $vec->posx / 3 );
    my $y = $tilelen * ( $pos->posy + $vec->posy / 3 );

    # add some fancy drawing
    my $radius = 2;
    $canvas->createOval(
        $x-$radius, $y-$radius,
        $x+$radius, $y+$radius,
        -outline => 'green',
        -tags => [ "$pos" ],
    );

}

sub switch {
    my ($self) = @_;
    $self->_set_switch( ($self->_switch + 1) % 2 );
}


__PACKAGE__->meta->make_immutable;
1;
__END__


=head1 DESCRIPTION

This package is a virtual class representing a node object with three
branches. There is a switch, meaning one can change the exit associated
to a given end.

The following methods are implemented in this class:

=over 4

=item * draw

=item * switch

=back

Refer to L<Games::RailRoad::Node> for a description of the various node
types and methods.
