use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::N_S_SE;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Switch };


# -- private methods

sub _next_map {
    return {
        'n'  => $_[0]->_sw_exits->[ $_[0]->_switch ],
        's'  => 'n',
        'se' => 'n',
    };
}


sub _sw_exits { return [ qw{ s se } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'nw'  => $prefix . 'Cross::N_NW_S_SE',
        '-s'  => $prefix . 'Straight::N_SE',
        '-se' => $prefix . 'Straight::N_S',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
