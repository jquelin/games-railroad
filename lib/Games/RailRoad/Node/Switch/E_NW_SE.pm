use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Switch::E_NW_SE;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Switch };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'e'  => 'nw',
        'nw' => $_[0]->_sw_exits->[ $_[0]->_switch ],
        'se' => 'nw',
    };
}


sub _sw_exits { return [ qw{ e se } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'w'   => $prefix . 'Cross::E_NW_SE_W',
        '-e'  => $prefix . 'Straight::NW_SE',
        '-se' => $prefix . 'Straight::E_NW',
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


