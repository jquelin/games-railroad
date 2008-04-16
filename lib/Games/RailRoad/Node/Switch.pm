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

sub new {
    my ($pkg, $opts) = @_;
    my $self = $pkg->SUPER::new($opts);
    $self->_switch(0);
    return $self;
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

