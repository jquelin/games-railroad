#
# This file is part of Games::RailRoad.
# Copyright (c) 2008 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#

package Games::RailRoad::Train;

use strict;
use warnings;
use 5.010;

use base qw{ Class::Accessor::Fast };
__PACKAGE__->mk_accessors( qw{ from to frac } );


# -- PUBLIC METHODS

sub draw {
    my ($self, $canvas, $tilelen) = @_;
    my $from = $self->from;
    my $to   = $self->to;
    my $frac = $self->frac;

    my $diag = 2;
    my $colf = $from->x; my $rowf = $from->y;
    my $colt =   $to->x; my $rowt =   $to->y;
    $canvas->delete("$self");
    my $x = ( $colf + ($colt-$colf) * $frac ) * $tilelen;
    my $y = ( $rowf + ($rowt-$rowf) * $frac ) * $tilelen;
    $canvas->createOval(
        $x - $diag, $y - $diag,
        $x + $diag, $y + $diag,
        -fill => 'blue',
        -tags => [ "$self" ],
    );
}


# -- PRIVATE METHODS


1;
__END__


=head1 NAME

Games::RailRoad::Train - a train object



=head1 DESCRIPTION

C<Games::RailRoad::Train> provides a train object.



=head1 CONSTRUCTOR

=head2 my $train = Games::RailRoad::Train->new( \%opts );

Create a new train object. One can pass a hash reference with the
following keys:


=over 4


=item from => $node

the node from where the train is coming.


=item to => $node

the node where the train is headed.


=item frac => $frac

a number between 0 and 1 indicating where exactly the train is between
its from and to nodes.


=back



=head1 PUBLIC METHODS

=head2 $train->draw( $canvas, $tilelen );

Request C<$train> to draw itself on C<$canvas>, assuming that each square
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

