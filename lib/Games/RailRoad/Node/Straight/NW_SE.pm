use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::NW_SE;
# ABSTRACT: a given type of node...

use base qw{ Games::RailRoad::Node::Straight };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'nw' => 'se',
        'se' => 'nw',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'e'   => $prefix . 'Switch::E_NW_SE',
        'n'   => $prefix . 'Switch::N_NW_SE',
        's'   => $prefix . 'Switch::NW_S_SE',
        'w'   => $prefix . 'Switch::NW_SE_W',
        '-nw' => $prefix . 'Half::SE',
        '-se' => $prefix . 'Half::NW',
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
