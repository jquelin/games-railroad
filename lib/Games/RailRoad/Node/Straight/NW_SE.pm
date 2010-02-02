use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::NW_SE;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Straight };


# -- private methods

sub _next_map {
    return {
        'nw' => 'se',
        'se' => 'nw',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'e'   => $prefix . 'Switch::E_NW_SE',
        'n'   => $prefix . 'Switch::N_NW_SE',
        's'   => $prefix . 'Switch::NW_S_SE',
        'w'   => $prefix . 'Switch::NW_SE_W',
        '-nw' => $prefix . 'Half::SE',
        '-se' => $prefix . 'Half::NW',
    };
}

__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
