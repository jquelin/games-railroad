use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::N_NW_S;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Switch };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'n'  => 's',
        'nw' => 's',
        's'  => $_[0]->_sw_exits->[ $_[0]->_switch ],
    };
}


sub _sw_exits { return [ qw{ n nw } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'se'  => $prefix . 'Cross::N_NW_S_SE',
        '-n'  => $prefix . 'Straight::NW_S',
        '-nw' => $prefix . 'Straight::N_S',
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
