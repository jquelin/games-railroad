use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::N_S_SW;
# ABSTRACT: a given type of node...

use Moose;
use base qw{ Games::RailRoad::Node::Switch };


# -- private methods

sub _next_map {
    return {
        'n'  => $_[0]->_sw_exits->[ $_[0]->_switch ],
        's'  => 'n',
        'sw' => 'n',
    };
}


sub _sw_exits { return [ qw{ s sw } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'ne'  => $prefix . 'Cross::N_NE_S_SW',
        '-s'  => $prefix . 'Straight::N_SW',
        '-sw' => $prefix . 'Straight::N_S',
    };
}


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.
