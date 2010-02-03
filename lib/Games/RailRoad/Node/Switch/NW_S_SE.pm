use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::NW_S_SE;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Switch };


# -- private methods

sub _next_map {
    return {
        'nw' => $_[0]->_sw_exits->[ $_[0]->_switch ],
        's'  => 'nw',
        'se' => 'nw',
    };
}


sub _sw_exits { return [ qw{ s se } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'n'   => $prefix . 'Cross::N_NW_S_SE',
        '-s'  => $prefix . 'Straight::NW_SE',
        '-se' => $prefix . 'Straight::NW_S',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
