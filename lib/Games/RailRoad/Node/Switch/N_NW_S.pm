use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::N_NW_S;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Switch };


# -- private methods

sub _next_map {
    return {
        'n'  => 's',
        'nw' => 's',
        's'  => $_[0]->_sw_exits->[ $_[0]->_switch ],
    };
}


sub _sw_exits { return [ qw{ n nw } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'se'  => $prefix . 'Cross::N_NW_S_SE',
        '-n'  => $prefix . 'Straight::NW_S',
        '-nw' => $prefix . 'Straight::N_S',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
