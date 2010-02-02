use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::E_SW;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Straight };


# -- private methods

sub _next_map {
    return {
        'e'  => 'sw',
        'sw' => 'e',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'ne'  => $prefix . 'Switch::E_NE_SW',
        'w'   => $prefix . 'Switch::E_SW_W',
        '-e'  => $prefix . 'Half::SW',
        '-sw' => $prefix . 'Half::E',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
