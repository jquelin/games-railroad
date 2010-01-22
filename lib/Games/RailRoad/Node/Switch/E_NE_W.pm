use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::E_NE_W;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Switch };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'e'  => 'w',
        'ne' => 'w',
        'w'  => $_[0]->_sw_exits->[ $_[0]->_switch ],
    };
}


sub _sw_exits { return [ qw{ e ne } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'sw'  => $prefix . 'Cross::E_NE_SW_W',
        '-e'  => $prefix . 'Straight::NE_W',
        '-ne' => $prefix . 'Straight::E_W',
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
