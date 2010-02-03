use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Cross::E_NW_SE_W;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Cross };


# -- private methods

sub _next_map {
    return {
        'e'  => 'w',
        'nw' => 'se',
        'se' => 'nw',
        'w'  => 'e',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        '-e'  => $prefix . 'Switch::NW_SE_W',
        '-nw' => $prefix . 'Switch::E_SE_W',
        '-se' => $prefix . 'Switch::E_NW_W',
        '-w'  => $prefix . 'Switch::E_NW_SE',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
