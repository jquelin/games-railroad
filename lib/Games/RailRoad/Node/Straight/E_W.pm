use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight::E_W;
# ABSTRACT: a node object

use base qw{ Games::RailRoad::Node::Straight };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'e'  => 'w',
        'w'  => 'e',
    };
}


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'ne'  => $prefix . 'Switch::E_NE_W',
        'nw'  => $prefix . 'Switch::E_NW_W',
        'se'  => $prefix . 'Switch::E_SE_W',
        'sw'  => $prefix . 'Switch::E_SW_W',
        '-e'  => $prefix . 'Half::W',
        '-w'  => $prefix . 'Half::E',
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



=head1 SEE ALSO

L<Games::RailRoad::Node>.



=head1 AUTHOR

Jerome Quelin, C<< <jquelin at cpan.org> >>



=head1 COPYRIGHT & LICENSE

Copyright (c) 2008 Jerome Quelin, all rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

