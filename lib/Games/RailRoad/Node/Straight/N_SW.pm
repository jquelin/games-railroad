use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::N_SW;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Straight };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'n'  => 'sw',
        'sw' => 'n',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'ne'  => $prefix . 'Switch::N_NE_SW',
        's'   => $prefix . 'Switch::N_S_SW',
        '-n'  => $prefix . 'Half::SW',
        '-sw' => $prefix . 'Half::N',
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
