use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node;
# ABSTRACT: a node object

use UNIVERSAL::require;

use base qw{ Class::Accessor::Fast };
__PACKAGE__->mk_accessors( qw{ position } );

# -- attributes

=attr position

The node position (a L<Games::RailRoad::Vector>).

=cut



# -- constructor & initializers

=method my $node = Games::RailRoad::Node->new( \%opts );

Create a new node object. One can pass a hash reference with the
available attributes.

=cut

# provided by moose


# -- public methods

=method $node->connect( $dir );

Try to extend C<$node> in the wanted C<$dir>. Return undef if it isn't
possible. In practice, note that the object will change of base class.

C<$dir> should be one of C<nw>, C<n>, C<ne>, C<w>, C<e>, C<sw>, C<s>,
C<se>. Of course, other values are accepted but won't result in a node
extension.

=cut

sub connect {
    my ($self, $dir) = @_;

    # check if the node can be extended in the wanted $dir.
    my $map = $self->_transform_map;
    return unless exists $map->{$dir};

    # rebless the object in its new class.
    $map->{$dir}->require;
    bless $self, $map->{$dir};

    # initialize switch if needed.
    # FIXME: shouldn't it be it GRN:Switch:_init with an inconditional
    #        call to _init?
    if ( $self->isa('Games::RailRoad::Node::Switch')
        && not defined $self->_switch ) {
        $self->_switch(0);
    }
}


=method $node->connectable( $dir );

Return true if C<$node> can be connected to the wanted C<$dir>. Return
false otherwise.

C<$dir> should be one of C<nw>, C<n>, C<ne>, C<w>, C<e>, C<sw>, C<s>,
C<se>. Of course, other values are accepted but will always return
false.

=cut

sub connectable {
    my ($self, $dir) = @_;
    my $map = $self->_transform_map;
    return exists $map->{$dir};
}


=method my @dirs = $node->connections;

Return a list of dirs in which the node is connected.

=cut

sub connections {
    my ($self) = @_;
    my $pkg = ref $self;
    return () if $pkg eq 'Games::RailRoad::Node';
    $pkg =~ s/^.*:://;
    return map { lc $_ } split /_/, $pkg;
}


=method $node->delete( $canvas );

Request C<$node> to remove itself from C<$canvas>.

=cut

sub delete {
    my ($self, $canvas) = @_;
    my $pos = $self->position;
    $canvas->delete("$pos");
}


=method $node->draw( $canvas, $tilelen );

Request C<$node> to draw itself on C<$canvas>, assuming that each square
has a length of C<$tilelen>. Note that this method calls the C<delete()>
method first.

=cut

sub draw {
    my ($self, $canvas, $tilelen) = @_;
    $self->delete($canvas);

    my $class = ref $self;
    $class =~ s/^.*:://;
    return if $class eq 'Node'; # naked node
    $self->_draw_segment(lc($_), $canvas, $tilelen)
        foreach split /_/, $class;
}


=method my $to = $node->next_dir( $from );

When C<$node> is reached by a train, this method will return the next
direction to head to, assuming the train was coming from C<$from>.

Note that the method can return undef if there's no such C<$from>
configured, or if the node is a dead-end.

=cut

sub next_dir {
    my ($self, $from) = @_;
    return $self->_next_map->{$from};
}


=method $node->switch;

Request a node to change its exit, if possible. This is a no-op for most
nodes, except C<Games::Railroad::Node::Switch::*>.

=cut

sub switch {}


# -- private methods

#
# $node->_draw_segment( $segment, $canvas, $tilelen )
#
# draw $segment of $node (at the correct col / row) on $canvas, assuming
# a square length of $tilelen. $segment can be one of nw, n, ne, w, e,
# sw, s, se.
#
sub _draw_segment {
    my ($self, $segment, $canvas, $tilelen) = @_;

    my $pos  = $self->position;
    my $col1 = $pos->x;
    my $row1 = $pos->y;
    my ($col2, $row2) = ($col1, $row1);

    # since each node is overlapping with the surrounding ones, we just
    # need to draw half of the segments.
    return unless $segment ~~ [ qw{ e sw s se } ];
    my $move = Games::RailRoad::Vector->new_dir($segment);
    my $end  = $pos + $move;

    # create the line.
    my $tags = [ "$pos", "$pos-$end" ];
    $canvas->createLine(
        $tilelen * $pos->x, $tilelen * $pos->y,
        $tilelen * $end->x, $tilelen * $end->y,
        -tags=>$tags
    );

    # add some fancy drawing
    my $div    = 3;
    my $radius = 1;
    foreach my $i ( 0 .. $div ) {
        my $x = $tilelen * ( $pos->x + $move->x * $i / $div );
        my $y = $tilelen * ( $pos->y + $move->y * $i / $div );
        $canvas->createOval(
            $x-$radius, $y-$radius,
            $x+$radius, $y+$radius,
            -fill => 'brown',
            -tags => $tags,
        );
    }

}


#
# my $map = $node->_transform_map;
#
# return a hashref, which keys are the directions where the node can be
# extended, and the values are the new class of the node after being
# extended.
#
sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'e'  => $prefix . 'Half::E',
        'n'  => $prefix . 'Half::N',
        'ne' => $prefix . 'Half::NE',
        'nw' => $prefix . 'Half::NW',
        's'  => $prefix . 'Half::S',
        'se' => $prefix . 'Half::SE',
        'sw' => $prefix . 'Half::SW',
        'w'  => $prefix . 'Half::W',
    };
}



1;
__END__


=head1 DESCRIPTION

This module provides a node object. This is the base class for the
following classes:

=over 4

=item *

L<Games::RailRoad::Node::Half> is a node with only one segment, from the
center to one of the 8 extremities of a square.

=item *

L<Games::RailRoad::Node::Straight> is a node with two segments, linking
two of the 8 extremities of a square.

=item *

L<Games::RailRoad::Node::Switch> is a node with three segments, linking
three of the 8 extremities of a square through the center. The I<active>
segment taken by a train riding this node can switch between two of the
segments.

=item *

L<Games::RailRoad::Node::Cross> is a node with four segments: two
straight lines crossing in the center of the square.

=back


Each of those classes also has subclasses, one for each configuration
allowed. They are named after each of the existing extremity of the
square linked (in uppercase), sorted and separated by underscore (C<_>).
For example: L<Games::RailRoad::Node::Switch::N_S_SE>.

Note that each segment coming out of a node belongs to 2 different
(adjacent) nodes.

