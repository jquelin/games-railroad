use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::E_SE_W;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Switch };


# -- private methods

sub _next_map {
    return {
        'e'  => 'w',
        'se' => 'w',
        'w'  => $_[0]->_sw_exits->[ $_[0]->_switch ],
    };
}


sub _sw_exits { return [ qw{ e se } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'nw'  => $prefix . 'Cross::E_NW_SE_W',
        '-e'  => $prefix . 'Straight::SE_W',
        '-se' => $prefix . 'Straight::E_W',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
