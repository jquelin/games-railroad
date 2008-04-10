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


#--
# constructor

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

    croak "missing parameter 'col'" unless defined $opts->{col};
    croak "missing parameter 'row'" unless defined $opts->{row};

    my $self = {
        col   => $opts->{col},
        row   => $opts->{row},
        _exit => {},
    };

    bless $self, $pkg;
    return $self;
}


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




=head1 SEE ALSO

L<Games::RailRoad::Rail>.



=head1 AUTHOR

Jerome Quelin, C<< <jquelin at cpan.org> >>



=head1 COPYRIGHT & LICENSE

Copyright (c) 2008 Jerome Quelin, all rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

