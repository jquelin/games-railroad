use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::N_SE;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Straight };


# -- private methods

sub _next_map {
    return {
        'n'  => 'se',
        'se' => 'n',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'nw'  => $prefix . 'Switch::N_NW_SE',
        's'   => $prefix . 'Switch::N_S_SE',
        '-n'  => $prefix . 'Half::SE',
        '-se' => $prefix . 'Half::N',
    };
}

__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
