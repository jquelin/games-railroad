use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::E_NE_SW;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Switch };


# -- private methods

sub _next_map {
    return {
        'e'  => 'sw',
        'ne' => 'sw',
        'sw' => $_[0]->_sw_exits->[ $_[0]->_switch ],
    };
}


sub _sw_exits { return [ qw{ e ne } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'w'   => $prefix . 'Cross::E_NE_SW_W',
        '-e'  => $prefix . 'Straight::NE_SW',
        '-ne' => $prefix . 'Straight::E_SW',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
