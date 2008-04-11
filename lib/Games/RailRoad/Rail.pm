#
# This file is part of Games::RailRoad.
# Copyright (c) 2008 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#

package Games::RailRoad::Rail;

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
    return if $class eq 'Rail'; # naked rail
    $self->_draw_segment(lc($_), $canvas, $tilelen)
        foreach split /_/, $class;
}


#
# $rail->extend_to( $dir );
#
# try to extend the rail in the wanted $dir. return undef if it isn't
# possible.
#
sub extend_to {
    my ($self, $dir) = @_;

    # check if the rail can be extended in the wanted $dir.
    my $map = $self->_transform_map;
    return unless exists $map->{$dir};

    # rebless the object in its new class.
    $map->{$dir}->require;
    bless $self, $map->{$dir};
}


# -- PRIVATE METHODS

#
# $rail->_draw_segment( $segment, $canvas, $tilelen )
#
# draw $segment of $rail (at the correct row / col) on $canvas, assuming
# a square length of $tilelen. $segment can be one of nw, n, ne, w, e,
# sw, s, se.
#
sub _draw_segment {
    my ($self, $segment, $canvas, $tilelen) = @_;

    my $row = $self->row;
    my $col = $self->col;

    # compute the end of the segment.
    my ($endx, $endy);
    given ($segment) {
        when('nw') { $endx = 0;          $endy = 0;          }
        when('n' ) { $endx = $tilelen/2; $endy = 0;          }
        when('ne') { $endx = $tilelen;   $endy = 0;          }
        when('w' ) { $endx = 0;          $endy = $tilelen/2; }
        when('e' ) { $endx = $tilelen;   $endy = $tilelen/2; }
        when('sw') { $endx = 0;          $endy = $tilelen;   }
        when('s' ) { $endx = $tilelen/2; $endy = $tilelen;   }
        when('se') { $endx = $tilelen;   $endy = $tilelen;   }
    }

    # create the line.
    $canvas->createLine(
        $col * $tilelen + $tilelen / 2,
        $row * $tilelen + $tilelen / 2,
        $col * $tilelen + $endx,
        $row * $tilelen + $endy,
        -tags => [ "$row-$col" ],
    );

}


#
# my $map = $rail->_transform_map;
#
# return a hashref, which keys are the directions where the rail can be
# extended, and the values are the new class of the rail after being
# extended.
#
sub _transform_map {
    my $prefix = 'Games::RailRoad::Rail::';
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

Games::RailRoad::Rail - a rail object



=head1 DESCRIPTION

C<Games::RailRoad::Rail> provides a rail object. This is the base class
for the following classes:

=over 4

=item *

C<Games::RailRoad::Rail::Half> is a rail with only one segment, from the
center to one of the 8 extremities of a square.

=item *

C<Games::RailRoad::Rail::Straight> is a rail with two segments, linking
two of the 8 extremities of a square.

=item *

C<Games::RailRoad::Rail::Switch> is a rail with three segments, linking
three of the 8 extremities of a square through the center. The I<active>
segment taken by a train riding this rail can switch between two of the
segments.  switch, 

=item *

C<Games::RailRoad::Rail::Cross> is a rail with four segments: two
straight lines crossing in the center of the square.

=back


Each of those classes also has subclasses, one for each configuration
allowed. They are named after each of the existing extremity of the
square linked (in uppercase), sorted and separated by underscore (C<_>).
For example: C<Games::RailRoad::Rail::Switch::N_S_SE>.



=head1 CONSTRUCTOR

=head2 my $rail = Games::RailRoad::Rail->new( \%opts );

Create a new rail object. One can pass a hash reference with the
following keys:

=over 4

=item col => $col

the column of the canvas where the rail is.

=item row => $row

the row of the canvas where the rail is.


=back



=head1 PUBLIC METHODS

=head2 $rail->draw( $canvas, $tilelen );

Request C<$rail> to draw itself on C<$canvas>, assuming that each square
has a length of C<$tilelen>.



=head2 $rail->extend_to( $dir );

Try to extend C<$rail> in the wanted C<$dir>. Return undef if it isn't
possible. In practice, note that the object will change of base class.

C<$dir> should be one of C<nw>, C<n>, C<ne>, C<w>, C<e>, C<sw>, C<s>,
C<se>. Of course, other values are accepted but won't result in a rail
extension.



=head1 SEE ALSO

L<Games::RailRoad>.



=head1 AUTHOR

Jerome Quelin, C<< <jquelin at cpan.org> >>



=head1 COPYRIGHT & LICENSE

Copyright (c) 2008 Jerome Quelin, all rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

