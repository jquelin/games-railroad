use 5.010;
use strict;
use warnings;

package Games::RailRoad::Train;
# ABSTRACT: a train object

use Moose;
use MooseX::Has::Sugar;
use MooseX::SemiAffordanceAccessor;

use Games::RailRoad::Types qw{ Num_0_1 };


# -- attributes

=attr from

The node from where the train is coming (a L<Games::RailRoad::Vector> object).

=attr to

The node where the train is headed (a L<Games::RailRoad::Vector> object).

=attr frac

A number between 0 and 1 indicating where exactly the train is between
its from and to nodes.

=cut

has from => ( rw, isa=>'Games::RailRoad::Vector' );
has to   => ( rw, isa=>'Games::RailRoad::Vector' );
has frac => ( rw, isa=>Num_0_1 );


# -- constructor & initializers

=method my $train = Games::RailRoad::Train->new( \%opts );

Create and return a new train object. One can pass a hash reference with
the available attributes.

=cut

# provided by moose


# -- public methods

=method $train->draw( $canvas, $tilelen );

Request C<$train> to draw itself on C<$canvas>, assuming that each square
has a length of C<$tilelen>.

=cut

sub draw {
    my ($self, $canvas, $tilelen) = @_;
    my $from = $self->from;
    my $to   = $self->to;
    my $frac = $self->frac;

    my $diag = 2;
    my $colf = $from->posx; my $rowf = $from->posy;
    my $colt =   $to->posx; my $rowt =   $to->posy;
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


# -- private methods


1;
__END__


=head1 DESCRIPTION

This class models a train object that moves on the rails.
