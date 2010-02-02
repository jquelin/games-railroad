use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::N_SW;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Straight };


# -- private methods

sub _next_map {
    return {
        'n'  => 'sw',
        'sw' => 'n',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'ne'  => $prefix . 'Switch::N_NE_SW',
        's'   => $prefix . 'Switch::N_S_SW',
        '-n'  => $prefix . 'Half::SW',
        '-sw' => $prefix . 'Half::N',
    };
}

__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
