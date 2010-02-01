use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Half::E;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Half };


# -- private methods

sub _transform_map {
    my $prefix = 'Games::RailRoad::Node';
    return {
        'nw'  => $prefix . '::Straight::E_NW',
        'sw'  => $prefix . '::Straight::E_SW',
        'w'   => $prefix . '::Straight::E_W',
        '-e'  => $prefix,
    };
}

__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
