use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Cross;
# ABSTRACT: a node object with 4 branches

use base qw{ Games::RailRoad::Node };


1;
__END__


=head1 DESCRIPTION

This package is a virtual class representing a node object with four
branches. This corresponds to 2 straight lines crossing each-other.

Refer to C<Games::RailRoad::Node> for a description of the various node
types.


