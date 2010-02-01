use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Cross::N_NW_S_SE;
# ABSTRACT: a given type of node...

use base qw{ Games::RailRoad::Node::Cross };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'n'  => 's',
        'nw' => 'se',
        's'  => 'n',
        'se' => 'nw',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        '-n'  => $prefix . 'Switch::NW_S_SE',
        '-nw' => $prefix . 'Switch::N_S_SE',
        '-s'  => $prefix . 'Switch::N_NW_SE',
        '-se' => $prefix . 'Switch::N_NW_S',
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
