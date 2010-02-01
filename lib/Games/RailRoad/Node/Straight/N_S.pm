use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::N_S;
# ABSTRACT: a given type of node...

use base qw{ Games::RailRoad::Node::Straight };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'n'  => 's',
        's'  => 'n',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'ne'  => $prefix . 'Switch::N_NE_S',
        'nw'  => $prefix . 'Switch::N_NW_S',
        'se'  => $prefix . 'Switch::N_S_SE',
        'sw'  => $prefix . 'Switch::N_S_SW',
        '-n'  => $prefix . 'Half::S',
        '-s'  => $prefix . 'Half::N',
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
