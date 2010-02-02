use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::NE_W;
# ABSTRACT: a given type of node...

use Moose;
extends qw{ Games::RailRoad::Node::Straight };


# -- private methods

sub _next_map {
    return {
        'ne' => 'w',
        'w'  => 'ne',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'e'   => $prefix . 'Switch::E_NE_W',
        'sw'  => $prefix . 'Switch::NE_SW_W',
        '-ne' => $prefix . 'Half::W',
        '-w'  => $prefix . 'Half::NE',
    };
}

__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
