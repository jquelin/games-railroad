use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::E_W;
# ABSTRACT: a given type of node...

use Moose;
use base qw{ Games::RailRoad::Node::Straight };


# -- private methods

sub _next_map {
    return {
        'e'  => 'w',
        'w'  => 'e',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'ne'  => $prefix . 'Switch::E_NE_W',
        'nw'  => $prefix . 'Switch::E_NW_W',
        'se'  => $prefix . 'Switch::E_SE_W',
        'sw'  => $prefix . 'Switch::E_SW_W',
        '-e'  => $prefix . 'Half::W',
        '-w'  => $prefix . 'Half::E',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
