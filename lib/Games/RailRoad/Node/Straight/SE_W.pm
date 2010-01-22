use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::SE_W;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Straight };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'se' => 'w',
        'w'  => 'se',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'e'   => $prefix . 'Switch::E_SE_W',
        'nw'  => $prefix . 'Switch::NW_SE_W',
        '-se' => $prefix . 'Half::W',
        '-w'  => $prefix . 'Half::SE',
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

