use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::N_SE;
# ABSTRACT: a given type of node...

use base qw{ Games::RailRoad::Node::Straight };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'n'  => 'se',
        'se' => 'n',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'nw'  => $prefix . 'Switch::N_NW_SE',
        's'   => $prefix . 'Switch::N_S_SE',
        '-n'  => $prefix . 'Half::SE',
        '-se' => $prefix . 'Half::N',
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
