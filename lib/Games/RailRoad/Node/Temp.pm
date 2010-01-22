use 5.010;
use strict;
use warnings;

package Games::RailRoad::Node::Temp;
# ABSTRACT: a node object not finished

use base qw{ Games::RailRoad::Node };


1;
__END__


=head1 DESCRIPTION

This package is a virtual class representing an unfinished node object -
unfinished as in "there's clearly a branch missing".

Refer to L<Games::RailRoad::Node> for a description of the various
node types.
