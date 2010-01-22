package Games::RailRoad::Node::Switch::N_S_SE;

use strict;
use warnings;

use base qw{ Games::RailRoad::Node::Switch };



# -- PRIVATE METHODS

sub _next_map {
    return {
        'n'  => $_[0]->_sw_exits->[ $_[0]->_switch ],
        's'  => 'n',
        'se' => 'n',
    };
}


sub _sw_exits { return [ qw{ s se } ]; }


sub _transform_map {
    my $prefix = 'Games::RailRoad::Node::';
    return {
        'nw'  => $prefix . 'Cross::N_NW_S_SE',
        '-s'  => $prefix . 'Straight::N_SE',
        '-se' => $prefix . 'Straight::N_S',
    };
}


1;
__END__


=head1 NAME

Games::RailRoad::Node::Switch::N_S_SE - a node object



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

