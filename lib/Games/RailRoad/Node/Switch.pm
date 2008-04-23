#
# This file is part of Games::RailRoad.
# Copyright (c) 2008 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#

package Games::RailRoad::Node::Switch;

use strict;
use warnings;
use 5.010;

use Games::RailRoad; # FIXME
use base qw{ Games::RailRoad::Node };
__PACKAGE__->mk_accessors( qw{ _switch } );

# -- PUBLIC METHODS

sub draw {
    my ($self, $canvas, $tilelen) = @_;
    $self->SUPER::draw($canvas, $tilelen);

    my $col = $self->col;
    my $row = $self->row;
    my $x = $col * $tilelen;
    my $y = $row * $tilelen;
    my $dir  = $self->_sw_exits->[ $self->_switch ];
    my $move = Games::RailRoad::_dir_coords($dir); # FIXME
    my ($dx,$dy) = split /,/, $move;

    $dx *= $tilelen / 3;
    $dy *= $tilelen / 3;
    $x += $dx;
    $y += $dy;

    # add some fancy drawing
    my $radius = 2;
    $canvas->createOval(
        $x-$radius, $y-$radius,
        $x+$radius, $y+$radius,
        -outline => 'green',
        -tags => [ "$col,$row" ],
    );

}

sub switch {
    my ($self) = @_;
    $self->_switch( ($self->_switch + 1) % 2 );
}


1;
__END__


=head1 NAME

Games::RailRoad::Node::Switch - a node object with three branches



=head1 DESCRIPTION

This package is a virtual class representing a node object with three
branches. There is a switch, meaning one can change the exit associated
to a given end.

The following methods are implemented in this class:

=over 4

=item * draw

=item * switch

=back

Refer to C<Games::RailRoad::Node> for a description of the various node
types and methods.



=head1 SEE ALSO

L<Games::RailRoad::Node>.



=head1 AUTHOR

Jerome Quelin, C<< <jquelin at cpan.org> >>



=head1 COPYRIGHT & LICENSE

Copyright (c) 2008 Jerome Quelin, all rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

