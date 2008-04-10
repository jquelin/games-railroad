#
# This file is part of Games::RailRoad.
# Copyright (c) 2008 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#

package Games::RailRoad::Rail::Straight::E_SW_W;

use strict;
use warnings;

use base qw{ Games::RailRoad::Rail::Straight };


# -- METHODS

sub transform_map {
    my $prefix = 'Games::RailRoad::Rail::';
    return {
        'ne' => $prefix . 'Cross::E_NE_SW_W',
    };
}


1;
__END__


=head1 NAME

Games::RailRoad::Rail::Straight::E_SW_W - a rail object



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

