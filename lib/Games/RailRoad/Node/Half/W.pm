use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Half::W;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Half };



# -- PRIVATE METHODS

sub _transform_map {
    my $prefix = 'Games::RailRoad::Node';
    return {
        'e'   => $prefix . '::Straight::E_W',
        'ne'  => $prefix . '::Straight::NE_W',
        'se'  => $prefix . '::Straight::SE_W',
        '-w'  => $prefix,
    };
}


1;
__END__


=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.



=head1 METHODS

This class implements the following methods as defined in
L<Games::RailRoad::Node>:

=over 4

=item * new


=back


Refer to the documentation in L<Games::RailRoad::Node> to learn more
about them.
