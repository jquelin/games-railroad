use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Cross::E_NW_SE_W;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Cross };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'e'  => 'w',
        'nw' => 'se',
        'se' => 'nw',
        'w'  => 'e',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        '-e'  => $prefix . 'Switch::NW_SE_W',
        '-nw' => $prefix . 'Switch::E_SE_W',
        '-se' => $prefix . 'Switch::E_NW_W',
        '-w'  => $prefix . 'Switch::E_NW_SE',
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
