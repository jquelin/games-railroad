use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Straight;
# ABSTRACT: a node object with two branches

use Moose;
extends qw{ Games::RailRoad::Node };

__PACKAGE__->meta->make_immutable;
1;
__END__

=head1 DESCRIPTION

This package is a virtual class representing a node object with only
two branches.

Refer to L<Games::RailRoad::Node> for a description of the various
node types.
