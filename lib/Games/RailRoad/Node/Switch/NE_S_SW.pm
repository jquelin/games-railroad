use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::NE_S_SW;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Switch };


# -- private methods

sub _next_map {
    return {
        'ne' => $_[0]->_sw_exits->[ $_[0]->_switch ],
        's'  => 'ne',
        'sw' => 'ne',
    };
}


sub _sw_exits { return [ qw{ s sw } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'n'   => $prefix . 'Cross::N_NE_S_SW',
        '-s'  => $prefix . 'Straight::NE_SW',
        '-sw' => $prefix . 'Straight::NE_S',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
