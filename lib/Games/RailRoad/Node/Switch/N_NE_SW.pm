use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::N_NE_SW;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Switch };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'n'  => 'sw',
        'ne' => 'sw',
        'sw' => $_[0]->_sw_exits->[ $_[0]->_switch ],
    };
}


sub _sw_exits { return [ qw{ n ne } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        's'   => $prefix . 'Cross::N_NE_S_SW',
        '-n'  => $prefix . 'Straight::NE_SW',
        '-ne' => $prefix . 'Straight::N_SW',
    };
}


1;
__END__


=head1 DESCRIPTION

This package provides a node object. Refer to L<Games::RailRoad::Node>
for a description of the various node types.



=head1 METHODS

This class implements the following methods as defined in
L<Games::RailRoad::Node>:

=over 4

=item * new


=back


Refer to the documentation in L<Games::RailRoad::Node> to learn more
about them.
