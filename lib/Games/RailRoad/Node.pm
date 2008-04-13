#
# This file is part of Games::RailRoad.
# Copyright (c) 2008 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#

package Games::RailRoad::Node;

use strict;
use warnings;
use 5.010;

use UNIVERSAL::require;

use base qw{ Class::Accessor::Fast };
__PACKAGE__->mk_accessors( qw{ col row } );


# -- PUBLIC METHODS

sub draw {
    my ($self, $canvas, $tilelen) = @_;
    my $row = $self->row;
    my $col = $self->col;
    $canvas->delete("$row-$col");

    my $class = ref $self;
    $class =~ s/^.*:://;
    return if $class eq 'Node'; # naked node
    $self->_draw_segment(lc($_), $canvas, $tilelen)
        foreach split /_/, $class;
}


#
# $node->connect( $dir );
#
# connect the node to the node in the wanted $dir. return undef if it
# isn't possible.
#
sub connect {
    my ($self, $dir) = @_;

    # check if the node can be extended in the wanted $dir.
    my $map = $self->_transform_map;
    return unless exists $map->{$dir};

    # rebless the object in its new class.
    $map->{$dir}->require;
    bless $self, $map->{$dir};
}


#
# $node->connectable( $dir );
#
# return true if the node can be connected to the node in the wanted
# $dir. return false otherwise.
#
sub connectable {
    my ($self, $dir) = @_;
    my $map = $self->_transform_map;
    return exists $map->{$dir};
}


# -- PRIVATE METHODS

#
# $node->_draw_segment( $segment, $canvas, $tilelen )
#
# draw $segment of $node (at the correct row / col) on $canvas, assuming
# a square length of $tilelen. $segment can be one of nw, n, ne, w, e,
# sw, s, se.
#
sub _draw_segment {
    my ($self, $segment, $canvas, $tilelen) = @_;

    my $row1 = $self->row;
    my $col1 = $self->col;
    my ($row2, $col2) = ($row1, $col1);

    # compute the end of the segment.
    my ($endx, $endy);
    given ($segment) {
        # since each node is overlapping with the surrounding ones, we
        # just need to draw half of the segments.
        when('e' ) { $endx=+$tilelen; $endy=0;        $col2=$col1+1;                }
        when('sw') { $endx=-$tilelen; $endy=$tilelen; $col2=$col1-1; $row2=$row1+1; }
        when('s' ) { $endx=0;         $endy=$tilelen;                $row2=$row1+1; }
        when('se') { $endx=+$tilelen; $endy=$tilelen; $col2=$col1+1; $row2=$row1+1; }
        default    { return; }
    }

    # create the line.
    $canvas->createLine(
        $col1 * $tilelen,
        $row1 * $tilelen,
        $col1 * $tilelen + $endx,
        $row1 * $tilelen + $endy,
        -tags => [ "$row1,$col1-$row2,$col2" ],
    );

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


=head1 NAME

Games::RailRoad::Node - a node object



=head1 DESCRIPTION

C<Games::RailRoad::Node> provides a node object. This is the base class
for the following classes:

=over 4

=item *

C<Games::RailRoad::Node::Half> is a node with only one segment, from the
center to one of the 8 extremities of a square.

=item *

C<Games::RailRoad::Node::Straight> is a node with two segments, linking
two of the 8 extremities of a square.

=item *

C<Games::RailRoad::Node::Switch> is a node with three segments, linking
three of the 8 extremities of a square through the center. The I<active>
segment taken by a train riding this node can switch between two of the
segments.

=item *

C<Games::RailRoad::Node::Cross> is a node with four segments: two
straight lines crossing in the center of the square.

=back


Each of those classes also has subclasses, one for each configuration
allowed. They are named after each of the existing extremity of the
square linked (in uppercase), sorted and separated by underscore (C<_>).
For example: C<Games::RailRoad::Node::Switch::N_S_SE>.


Note that each segment coming out of a node belongs to 2 different
(adjacent) nodes.



=head1 CONSTRUCTOR

=head2 my $node = Games::RailRoad::Node->new( \%opts );

Create a new node object. One can pass a hash reference with the
following keys:

=over 4

=item col => $col

the column of the canvas where the node is.

=item row => $row

the row of the canvas where the node is.


=back



=head1 PUBLIC METHODS

=head2 $node->connect( $dir );

Try to extend C<$node> in the wanted C<$dir>. Return undef if it isn't
possible. In practice, note that the object will change of base class.

C<$dir> should be one of C<nw>, C<n>, C<ne>, C<w>, C<e>, C<sw>, C<s>,
C<se>. Of course, other values are accepted but won't result in a node
extension.



=head2 $node->connectable( $dir );

Return true if C<$node> can be connected to the wanted C<$dir>. Return
false otherwise.

C<$dir> should be one of C<nw>, C<n>, C<ne>, C<w>, C<e>, C<sw>, C<s>,
C<se>. Of course, other values are accepted but will return always
false.


=head2 $node->draw( $canvas, $tilelen );

Request C<$node> to draw itself on C<$canvas>, assuming that each square
has a length of C<$tilelen>.



=head1 SEE ALSO

L<Games::RailRoad>.



=head1 AUTHOR

Jerome Quelin, C<< <jquelin at cpan.org> >>



=head1 COPYRIGHT & LICENSE

Copyright (c) 2008 Jerome Quelin, all rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

