use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::E_NE_W;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Switch };


# -- private methods

sub _next_map {
    return {
        'e'  => 'w',
        'ne' => 'w',
        'w'  => $_[0]->_sw_exits->[ $_[0]->_switch ],
    };
}


sub _sw_exits { return [ qw{ e ne } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'sw'  => $prefix . 'Cross::E_NE_SW_W',
        '-e'  => $prefix . 'Straight::NE_W',
        '-ne' => $prefix . 'Straight::E_W',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
