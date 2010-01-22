use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::NE_SW_W;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Switch };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'ne' => $_[0]->_sw_exits->[ $_[0]->_switch ],
        'sw' => 'ne',
        'w'  => 'ne',
    };
}


sub _sw_exits { return [ qw{ e ne } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'e'   => $prefix . 'Cross::E_NE_SW_W',
        '-sw' => $prefix . 'Straight::NE_W',
        '-w'  => $prefix . 'Straight::NE_SW',
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
