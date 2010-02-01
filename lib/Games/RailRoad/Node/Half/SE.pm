use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Half::SE;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Half };


# -- private methods

sub _transform_map {
    my $prefix = 'Games::RailRoad::Node';
    return {
        'n'   => $prefix . '::Straight::N_SE',
        'nw'  => $prefix . '::Straight::NW_SE',
        'w'   => $prefix . '::Straight::SE_W',
        '-se' => $prefix,
    };
}

__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
