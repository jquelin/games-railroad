#
# This file is part of Games::RailRoad.
# Copyright (c) 2008 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#

package Games::RailRoad::Rail::Straight::N_S_SE;

use strict;
use warnings;

use base qw{ Games::RailRoad::Rail::Straight };


# -- METHODS

sub _transform_map {
    my $prefix = 'Games::RailRoad::Rail::';
    return {
        'nw' => $prefix . 'Cross::N_NW_S_SE',
    };
}


1;
__END__


=head1 NAME

Games::RailRoad::Rail::Straight::N_S_SE - a rail object



=head1 DESCRIPTION

This package provides a rail object. Refer to C<Games::RailRoad::Rail>
for a description of the various rail types.



=head1 METHODS

This class implements the following methods as defined in
C<Games::RailRoad::Rail>:

=over 4

=item * new

=item * transform_map

=back


Refer to the documentation in C<Games::RailRoad::Rail> to learn more
about them.



=head1 SEE ALSO

L<Games::RailRoad::Rail>.



=head1 AUTHOR

Jerome Quelin, C<< <jquelin at cpan.org> >>



=head1 COPYRIGHT & LICENSE

Copyright (c) 2008 Jerome Quelin, all rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

