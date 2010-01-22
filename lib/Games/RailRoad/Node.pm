package Games::RailRoad::Node;

use strict;
use warnings;
use 5.010;

use UNIVERSAL::require;

use base qw{ Class::Accessor::Fast };
__PACKAGE__->mk_accessors( qw{ position } );


# -- PUBLIC METHODS

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

    # initialize switch if needed.
    # FIXME: shouldn't it be it GRN:Switch:_init with an inconditional
    #        call to _init?
    if ( $self->isa('Games::RailRoad::Node::Switch')
        && not defined $self->_switch ) {
        $self->_switch(0);
    }
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


#
# my @dirs = $node->connections;
#
# return a list of dirs in which the node is connected.
#
sub connections {
    my ($self) = @_;
    my $pkg = ref $self;
    return () if $pkg eq 'Games::RailRoad::Node';
    $pkg =~ s/^.*:://;
    return map { lc $_ } split /_/, $pkg;
}


#
# $node->delete( $canvas );
#
# request $node to delete itself from $canvas.
#
sub delete {
    my ($self, $canvas) = @_;
    my $pos = $self->position;
    $canvas->delete("$pos");
}

#
# $node->draw( $canvas, $tilelen );
#
# request $node to draw itself on $canvas, assuming that each
# square has a length of $tilelen.
#
sub draw {
    my ($self, $canvas, $tilelen) = @_;
    $self->delete($canvas);

    my $class = ref $self;
    $class =~ s/^.*:://;
    return if $class eq 'Node'; # naked node
    $self->_draw_segment(lc($_), $canvas, $tilelen)
        foreach split /_/, $class;
}


#
# my $to = $node->next_dir( $from );
#
# when $node is reached by a train, this method will return the next
# direction to head to, assuming the train was coming from $from.
#
# can return undef if there's no such $from configured, or if the node
# is a dead-end.
#
sub next_dir {
    my ($self, $from) = @_;
    return $self->_next_map->{$from};
}


#
# $node->switch;
#
# request a node to change its exit, if possible. this is a no-op for
# most nodes, except games::railroad::node::switch::*
#
sub switch {}


# -- PRIVATE METHODS

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



=head2 my @dirs = $node->connections;

Return a list of dirs in which the node is connected.



=head2 $node->delete( $canvas );

Request C<$node> to remove itself from C<$canvas>.



=head2 $node->draw( $canvas, $tilelen );

Request C<$node> to draw itself on C<$canvas>, assuming that each square
has a length of C<$tilelen>. Note that this method calls the C<delete()>
method first.



=head2 my $to = $node->next_dir( $from );

When C<$node> is reached by a train, this method will return the next
direction to head to, assuming the train was coming from C<$from>.

Note that the method can return undef if there's no such C<$from>
configured, or if the node is a dead-end.



=head2 $node->switch;

Request a node to change its exit, if possible. This is a no-op for most
nodes, except C<Games::Railroad::Node::Switch::*>.



=head1 SEE ALSO

L<Games::RailRoad>.



=head1 AUTHOR

Jerome Quelin, C<< <jquelin at cpan.org> >>



=head1 COPYRIGHT & LICENSE

Copyright (c) 2008 Jerome Quelin, all rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

