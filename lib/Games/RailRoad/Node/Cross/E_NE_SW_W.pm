use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Cross::E_NE_SW_W;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Cross };


# -- private methods

sub _next_map {
    return {
        'e'  => 'w',
        'ne' => 'sw',
        'sw' => 'ne',
        'w'  => 'e',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        '-e'  => $prefix . 'Switch::NE_SW_W',
        '-ne' => $prefix . 'Switch::E_SW_W',
        '-sw' => $prefix . 'Switch::E_NE_W',
        '-w'  => $prefix . 'Switch::E_NE_SW',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
