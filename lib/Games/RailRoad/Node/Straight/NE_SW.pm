use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::NE_SW;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Straight };


# -- private methods

sub _next_map {
    return {
        'ne' => 'sw',
        'sw' => 'ne',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'e'   => $prefix . 'Switch::E_NE_SW',
        'n'   => $prefix . 'Switch::N_NE_SW',
        's'   => $prefix . 'Switch::NE_S_SW',
        'w'   => $prefix . 'Switch::NE_SW_W',
        '-ne' => $prefix . 'Half::SW',
        '-sw' => $prefix . 'Half::NE',
    };
}

__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
