use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Half;
# ABSTRACT: a node object with one branch

use base qw{ Games::RailRoad::Node };

# -- PRIVATE METHODS

sub _next_map {
    return {};
}


1;
__END__


=head1 DESCRIPTION

This package is a virtual class representing a node object with only
one branch.

Refer to C<Games::RailRoad::Node> for a description of the various node
types.



=head1 SEE ALSO

L<Games::RailRoad::Node>.



=head1 AUTHOR

Jerome Quelin, C<< <jquelin at cpan.org> >>



=head1 COPYRIGHT & LICENSE

Copyright (c) 2008 Jerome Quelin, all rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

