use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::E_SW_W;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Switch };


# -- private methods

sub _next_map {
    return {
        'e'  => $_[0]->_sw_exits->[ $_[0]->_switch ],
        'sw' => 'e',
        'w'  => 'e',
    };
}


sub _sw_exits { return [ qw{ sw w } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'ne'  => $prefix . 'Cross::E_NE_SW_W',
        '-sw' => $prefix . 'Straight::E_W',
        '-w'  => $prefix . 'Straight::E_SW',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
