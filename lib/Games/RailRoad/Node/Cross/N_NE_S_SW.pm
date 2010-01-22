use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Cross::N_NE_S_SW;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Cross };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'n'  => 's',
        'ne' => 'sw',
        's'  => 'n',
        'sw' => 'ne',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        '-n'  => $prefix . 'Switch::NE_S_SW',
        '-ne' => $prefix . 'Switch::N_S_SW',
        '-s'  => $prefix . 'Switch::N_NE_SW',
        '-sw' => $prefix . 'Switch::N_NE_S',
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
