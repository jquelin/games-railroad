use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Cross::E_NE_SW_W;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Cross };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'e'  => 'w',
        'ne' => 'sw',
        'sw' => 'ne',
        'w'  => 'e',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        '-e'  => $prefix . 'Switch::NE_SW_W',
        '-ne' => $prefix . 'Switch::E_SW_W',
        '-sw' => $prefix . 'Switch::E_NE_W',
        '-w'  => $prefix . 'Switch::E_NE_SW',
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

