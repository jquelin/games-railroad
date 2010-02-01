use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::N_NE_S;
# ABSTRACT: a given type of node...

use base qw{ Games::RailRoad::Node::Switch };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'n'  => 's',
        'ne' => 's',
        's'  => $_[0]->_sw_exits->[ $_[0]->_switch ],
    };
}


sub _sw_exits { return [ qw{ n ne } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'sw'  => $prefix . 'Cross::N_NE_S_SW',
        '-n'  => $prefix . 'Straight::NE_S',
        '-ne' => $prefix . 'Straight::N_S',
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
