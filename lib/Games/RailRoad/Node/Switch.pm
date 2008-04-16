#
# This file is part of Games::RailRoad.
# Copyright (c) 2008 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#

package Games::RailRoad::Node::Switch;

use strict;
use warnings;

use base qw{ Games::RailRoad::Node };
__PACKAGE__->mk_accessors( qw{ _switch } );

# -- PUBLIC METHODS

sub switch {
    my ($self) = @_;
    $self->_switch( ($self->_switch + 1) % 2 );
}


1;
__END__


=head1 NAME

Games::RailRoad::Node::Switch - a node object with three branches



=head1 DESCRIPTION

This package is a virtual class representing a node object with three
branches. There is a switch, meaning one can change the exit associated
to a given end.

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

