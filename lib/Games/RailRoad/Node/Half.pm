use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Half;
# ABSTRACT: a node object with one branch

use Moose;
extends qw{ Games::RailRoad::Node };


# -- private methods

sub _next_map { return {}; }


__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package is a virtual class representing a node object with only
one branch.

Refer to L<Games::RailRoad::Node> for a description of the various
node types.
