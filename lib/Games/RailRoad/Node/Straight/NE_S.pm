use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::NE_S;
# ABSTRACT: a given type of node...

use base qw{ Games::RailRoad::Node::Straight };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'ne' => 's',
        's'  => 'ne',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'n'   => $prefix . 'Switch::N_NE_S',
        'sw'  => $prefix . 'Switch::NE_S_SW',
        '-ne' => $prefix . 'Half::S',
        '-s'  => $prefix . 'Half::NE',
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
