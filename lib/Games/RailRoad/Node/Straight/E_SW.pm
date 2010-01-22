use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::E_SW;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Straight };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'e'  => 'sw',
        'sw' => 'e',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'ne'  => $prefix . 'Switch::E_NE_SW',
        'w'   => $prefix . 'Switch::E_SW_W',
        '-e'  => $prefix . 'Half::SW',
        '-sw' => $prefix . 'Half::E',
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


