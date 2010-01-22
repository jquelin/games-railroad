use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::NW_S_SE;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Switch };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'nw' => $_[0]->_sw_exits->[ $_[0]->_switch ],
        's'  => 'nw',
        'se' => 'nw',
    };
}


sub _sw_exits { return [ qw{ s se } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'n'   => $prefix . 'Cross::N_NW_S_SE',
        '-s'  => $prefix . 'Straight::NW_SE',
        '-se' => $prefix . 'Straight::NW_S',
    };
}


1;
__END__


=head1 DESCRIPTION

This package provides a node object. Refer to C<Games::RailRoad::Node>
for a description of the various node types.



=head1 METHODS

This class implements the following methods as defined in
C<Games::RailRoad::Node>:

=over 4

=item * new


=back


Refer to the documentation in C<Games::RailRoad::Node> to learn more
about them.
