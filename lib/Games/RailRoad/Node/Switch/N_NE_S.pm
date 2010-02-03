use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::N_NE_S;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Switch };


# -- private methods

sub _next_map {
    return {
        'n'  => 's',
        'ne' => 's',
        's'  => $_[0]->_sw_exits->[ $_[0]->_switch ],
    };
}


sub _sw_exits { return [ qw{ n ne } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'sw'  => $prefix . 'Cross::N_NE_S_SW',
        '-n'  => $prefix . 'Straight::NE_S',
        '-ne' => $prefix . 'Straight::N_S',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
