use 5.010;
use strict;
use warnings;

package Games::RailRoad::Types;
# ABSTRACT: private types for the distribution

use MooseX::Types -declare => [ qw{ Num_0_1 } ];
use MooseX::Types::Moose qw{ Num };


# -- type definition

subtype Num_0_1,
    as Num,
    where   { $_ >= 0 && $_ <= 1},
    message { 'Num should be between 0 and 1' };

1;
__END__

=head1 DESCRIPTION

This module is defining some L<Moose> subtypes to be used elsewhere in
the distribution.

Available types exported:

=over 4

=item * Num_0_1

A float between 0 and 1.

=back
