use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::NW_S;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Straight };


# -- private methods

sub _next_map {
    return {
        'nw' => 's',
        's'  => 'nw',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'n'   => $prefix . 'Switch::N_NW_S',
        'se'  => $prefix . 'Switch::NW_S_SE',
        '-nw' => $prefix . 'Half::S',
        '-s'  => $prefix . 'Half::NW',
    };
}

__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
