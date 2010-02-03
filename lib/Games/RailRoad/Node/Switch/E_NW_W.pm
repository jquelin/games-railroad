use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::E_NW_W;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Switch };


# -- private methods

sub _next_map {
    return {
        'e'  => $_[0]->_sw_exits->[ $_[0]->_switch ],
        'nw' => 'e',
        'w'  => 'e',
    };
}


sub _sw_exits { return [ qw{ nw w } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'se'  => $prefix . 'Cross::E_NW_SE_W',
        '-nw' => $prefix . 'Straight::E_W',
        '-w'  => $prefix . 'Straight::E_NW',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
