use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::E_NW;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Straight };


# -- PRIVATE METHODS

sub _next_map {
    return {
        'e'  => 'nw',
        'nw' => 'e',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'se'  => $prefix . 'Switch::E_NW_SE',
        'w'   => $prefix . 'Switch::E_NW_W',
        '-e'  => $prefix . 'Half::NW',
        '-nw' => $prefix . 'Half::E',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
