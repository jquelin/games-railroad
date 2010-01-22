use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Half::SE;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Half };



# -- PRIVATE METHODS

sub _transform_map {
    my $prefix = 'Games::RailRoad::Node';
    return {
        'n'   => $prefix . '::Straight::N_SE',
        'nw'  => $prefix . '::Straight::NW_SE',
        'w'   => $prefix . '::Straight::SE_W',
        '-se' => $prefix,
    };
}


1;
__END__


=head1 DESCRIPTION

This package provides a node object. Refer to C<Games::RailRoad::Node>
for a description of the various node types.



=head1 METHODS

This class implements the following methods as defined in
C<Games::RailRoad::Node>:

=over 4

=item * new


=back


Refer to the documentation in C<Games::RailRoad::Node> to learn more
about them.


