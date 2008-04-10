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

use Carp;
use base qw{ Class::Accessor::Fast };
__PACKAGE__->mk_accessors( qw{ col row _exit } );


# -- CONSTRUCTOR

#
# my $id = Games::RailRoad->new(%opts);
#
# create a new rail object. refer to the embedded
# pod for an explanation of the supported options.
#
# regarding the internals of the object: there's an _exit accessor which
# is a hash reference. the keys are the existing entries of the rail,
# according to the following schema:
#
#       nw  n  ne
#       w       e
#       sw  s  se
#
# the values are the exit associated to the entry point. eg, for a
# vertical rail, the following pairs will exist: w->e and e->w. those
# can be changed later on with the methods dis/connect().
#
sub new {
    my ($pkg, %opts) = @_;

    croak "missing parameter 'row'" unless defined $opts{row};
    croak "missing parameter 'col'" unless defined $opts{col};
    print "new: $opts{row},$opts{col}\n";

    my $self = {
        row   => $opts{row},
        col   => $opts{col},
        _exit => {},
    };

    bless $self, $pkg;
    return $self;
}


# -- PUBLIC METHODS

#
# $rail->connect( $origin, $end );
#
# connect $end as the exit when coming from $origin. note that when $end
# is undef, this just means that there is currently no exit associated
# to $exit.
#
sub connect {
    my ($self, $origin, $end) = @_;
    $self->_exit->{$origin} = $end;
}


1;
__END__


=head1 NAME

Games::RailRoad::Rail - a rail object



=head1 DESCRIPTION

C<Games::RailRoad::Rail> provides a rail object, mapped on a tile in the
canvas.



=head1 CONSTRUCTOR

=head2 my $rail = Games::RailRoad::Rail->new( %opts );

Create a new rail object. One can pass the following options:

=over 4

=item col => $col

the column of the canvas where the rail is.

=item row => $row

the row of the canvas where the rail is.


=back



=head1 PUBLIC METHODS

=head2 $rail->connect( $origin, $end );

Connect C<$end> as the exit when coming from C<$origin>. Note that when
C<$end> is undef, this just means that there is currently no exit
associated to C<$exit>.

C<$origin> and C<$end> should be one of C<nw>, C<n>, C<ne>, C<w>, C<e>,
C<sw>, C<s>, C<se>.



=head1 SEE ALSO

L<Games::RailRoad::Rail>.



=head1 AUTHOR

Jerome Quelin, C<< <jquelin at cpan.org> >>



=head1 COPYRIGHT & LICENSE

Copyright (c) 2008 Jerome Quelin, all rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

