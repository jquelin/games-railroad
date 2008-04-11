#
# This file is part of Games::RailRoad.
# Copyright (c) 2008 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#

package Games::RailRoad;

use strict;
use warnings;
use 5.010;

use Games::RailRoad::Rail;
use Readonly;
use Tk; # should come before POE
use Tk::Dialog;
use Tk::FBox;
use Tk::ToolBar;
use POE;


our $VERSION = '0.01';

Readonly my $NBROWS  => 40;
Readonly my $NBCOLS  => 60;
Readonly my $TILELEN => 20; # in pixels

#Readonly my @COLORS => ( [255,0,0], [0,0,255], [0,255,0], [255,255,0], [255,0,255], [0,255,255] );


# -- CONSTRUCTOR

#
# my $id = Games::RailRoad->spawn(%opts);
#
# create a new game window. refer to the embedded
# pod for an explanation of the supported options.
#
sub spawn {
    my ($class, %opts) = @_;

    my $session = POE::Session->create(
        inline_states => {
            # special poe events
            _start           => \&_on_start,
            # public events
            # private events
            _redraw_tile     => \&_on_redraw_tile,
            # gui events
            _b_quit          => \&_on_b_quit,
            _c_b1_motion     => \&_on_c_b1_motion,
            _c_b1_press      => \&_on_c_b1_press,
        },
        args => \%opts,
    );
    return $session->ID;
}


# -- PUBLIC EVENTS


# -- PRIVATE EVENTS

#
# _on_redraw_tile( $row, $col );
#
# request for a tile to be redrawn.
#
sub _on_redraw_tile {
    my ($h, $row, $col) = @_[ HEAP, ARG0 .. $#_ ];
    $h->{rails}{"$row-$col"}->draw( $h->{w}{canvas}, $TILELEN );
}


#
# _on_start( \%opts );
#
# session initialization. %opts is received from spawn();
#
sub _on_start {
    my ($k, $h, $s, $opts) = @_[ KERNEL, HEAP, SESSION, ARG0 ];

    #-- create gui

    # prettyfying tk app.
    # see http://www.perltk.org/index.php?option=com_content&task=view&id=43&Itemid=37
    $poe_main_window->optionAdd('*BorderWidth' => 1);

    # menu
    $poe_main_window->optionAdd('*tearOff', 'false'); # no tear-off menus
    my $menuitems = [
        [ Cascade => '~File', -menuitems => [
            [ Button => '~Open',
                -command     => $s->postback('_b_open'),
                -accelerator => 'ctrl+o',
                -compound    => 'left',
                -image       => $poe_main_window->Photo('fileopen16'),
                ],
            [ Separator => '' ],
            [ Button => '~Quit',
                -command     => $s->postback('_b_quit'),
                -accelerator => 'ctrl+q',
                -compound    => 'left',
                -image       => $poe_main_window->Photo('actexit16'),
                ],
            ],
        ],
        [ Cascade => '~Run', -menuitems => [
            [ Button => '~Restart',
                -command     => $s->postback('_b_restart'),
                -accelerator => 'R',
                -compound    => 'left',
                -image       => $poe_main_window->Photo('playstart16'),
                ],
            [ Button => '~Pause',
                -command     => $s->postback('_b_pause'),
                -accelerator => 'p',
                -compound    => 'left',
                -image       => $poe_main_window->Photo('playpause16'),
                ],
            [ Button => '~Next',
                -command     => $s->postback('_b_next'),
                -accelerator => 'n',
                -compound    => 'left',
                -image       => $poe_main_window->Photo('nav1rightarrow16'),
                ],
            [ Button => '~Continue',
                -command     => $s->postback('_b_continue'),
                -accelerator => 'c',
                -compound    => 'left',
                -image       => $poe_main_window->Photo('nav2rightarrow16'),
                ],
            [ Separator => '' ],
            [ Button => '~Breakpoints',
                -command     => $s->postback('_b_breakpoints'),
                #-accelerator => 'c',
                -compound    => 'left',
                -image       => $poe_main_window->Photo('calbell16'),
                ],
            ],
        ],
    ];
    my $menubar = $poe_main_window->Menu( -menuitems => $menuitems );
    $poe_main_window->configure( -menu => $menubar );
    $h->{w}{mnu_run} = $menubar->entrycget(1, '-menu');


    # toolbar
    my @tb = (
        [ 'Button', 'actexit16',        'quit',        '<Control-q>', '_b_quit' ],
        [ 'Button', 'fileopen16',       'open',        '<Control-o>', '_b_open' ],
        [ 'separator' ],
        [ 'Button', 'calbell16',        'breakpoints', '<F8>',        '_b_breakpoints' ],
        [ 'separator' ],
        [ 'Button', 'playstart16',      'restart',     '<R>',         '_b_restart' ],
        [ 'Button', 'playpause16',      'pause',       '<p>',         '_b_pause' ],
        [ 'Button', 'nav1rightarrow16', 'next',        '<n>',         '_b_next' ],
        [ 'Button', 'nav2rightarrow16', 'continue',    '<c>',         '_b_continue' ],
    );
    my $tb = $poe_main_window->ToolBar(-movable=>0);
    foreach my $item ( @tb ) {
        my $type = shift @$item;
        $tb->separator( -movable => 0 ), next if $type eq 'separator';
        $h->{w}{$item->[3]} = $tb->$type(
            -image       => $item->[0],
            -tip         => $item->[1],
            -accelerator => $item->[2],
            -command     => $s->postback($item->[3]),
        );
    }

    # playfield
    #my $fh1 = $->Frame->pack(-fill=>'both', -expand=>1);
    my $c = $poe_main_window->Scrolled( 'Canvas',
        -bg         => 'white',
        -scrollbars => 'osoe',
        -width      => $NBCOLS * $TILELEN,
        -height     => $NBROWS * $TILELEN,
        #-browsecmd  => $s->postback('_tm_click'),
    )->pack(-side=>'left', -fill=>'both', -expand=>1);
    $c->createGrid( 0, 0, $TILELEN, $TILELEN, -lines => 0 );
    $c->CanvasBind( '<ButtonPress-1>', [$s->postback('_c_b1_press'),  Ev('x'), Ev('y')] );
    $c->CanvasBind( '<B1-Motion>',     [$s->postback('_c_b1_motion'), Ev('x'), Ev('y')] );
    $h->{w}{canvas} = $c;

    # -- various heap initializations
    $h->{rails} = {};
    #$k->yield( $opts->{file} ? ('_open_file', $opts->{file}) : '_b_open' );
}


# -- GUI EVENTS

#
# _b_quit();
#
# called when the user wants to quit the application.
#
sub _on_b_quit {
    $poe_main_window->destroy;
}


#
# _on_c_b1_motion( [], [$stuff, $x, $y] );
#
# called when the mouse is moving on canvas while button is down.
#
sub _on_c_b1_motion {
    my ($k,$h, $args) = @_[KERNEL, HEAP, ARG1];
    my (undef, $x, $y) = @$args;
    my ($row, $col, $region) = _resolve_coords($x,$y);

    # check if we moved somehow.
    my $curtile  = "$row-$col";
    my $curpos   = "$row-$col-$region";
    return if $h->{curpos} eq $curpos;
    $h->{curpos} = $curpos;

    # create a new rail object if needed.
    $h->{rails}{$curtile} //= Games::RailRoad::Rail->new({row=>$row,col=>$col});

    # extend rail under the mouse if possible.
    $h->{rails}{$curtile}->extend_to($region)
        and $k->yield( '_redraw_tile', $row, $col );
}


#
# _on_c_b1_press( [], [$stuff, $x, $y] );
#
# called when the button mouse is pressed on canvas.
#
sub _on_c_b1_press {
    my ($k,$h, $args) = @_[KERNEL, HEAP, ARG1];
    my (undef, $x, $y) = @$args;
    my ($row, $col, $region) = _resolve_coords($x,$y);

    # save current position.
    my $curtile  = "$row-$col";
    my $curpos   = "$row-$col-$region";
    $h->{curpos} = $curpos;

    # create a new rail object if needed.
    $h->{rails}{$curtile} //= Games::RailRoad::Rail->new({row=>$row,col=>$col});

    return if $region eq 'c'; # center is not precise enough

    # extend rail under the mouse if possible.
    $h->{rails}{$curtile}->extend_to($region)
        and $k->yield( '_redraw_tile', $row, $col );
}


# -- PRIVATE SUBS

#
# my ($row, $col, $region) = _resolve_coords($x,$y);
# my $coords = _resolve_coords($x,$y);
#
# the canvas deals with pixels: this sub transforms canvas coordinates
# ($x,$y) in the $row and $col of the matching tile. it will also return
# the region of the tile:
#   - nw: north-west
#   - n:  norh
#   - ne: north-east
#   - w:  west
#   - c:  center
#   - e:  east
#   - sw: south-west
#   - s:  south
#   - se: south-east
#
# in scalar context, return the string "$row-$col-$region".
#
sub _resolve_coords {
    my ($x,$y) = @_;

    # easy stuff
    my $col = int( $x/$TILELEN );
    my $row = int( $y/$TILELEN );

    # more complex: the region
    $x -= $col * $TILELEN;
    $y -= $row * $TILELEN;
    my ($rx,$ry);
    given ($x) {
        when( $_ < $TILELEN / 3 )   { $rx = 'w'; }
        when( $_ > $TILELEN * 2/3 ) { $rx = 'e'; }
        default { $rx = ''; }
    }
    given ($y) {
        when( $_ < $TILELEN / 3 )   { $ry = 'n'; }
        when( $_ > $TILELEN * 2/3 ) { $ry = 's'; }
        default { $ry = ''; }
    }
    my $region = ($ry . $rx) || 'c';

    return wantarray ? ($row, $col, $region) : "$row-$col-$region";
}


1;

__END__


=head1 NAME

Games::RailRoad - a train simulation game



=head1 DESCRIPTION

C<Games::RailRoad> allows you to draw a railroad, create some trains and
make them move on it. What you did when you were kid, but on your computer
now.



=head1 CLASS METHODS

=head2 my $id = Games::RailRoad->spawn( %opts );

Create a new game, and return the associated POE session ID.
No option supported as of now.



=head1 PUBLIC EVENTS

The POE session accepts the following events:


=over 4

=item none yet.


=back



=head1 BUGS

Please report any bugs or feature requests to C<< < games-railroad at
rt.cpan.org> >>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-RailRoad>.  I
will be notified, and then you'll automatically be notified of progress
on your bug as I make changes.



=head1 SEE ALSO

L<POE>, L<Tk>.


You can also look for information on this module at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-RailRoad>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-RailRoad>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-RailRoad>

=back



=head1 AUTHOR

Jerome Quelin, C<< <jquelin at cpan.org> >>



=head1 COPYRIGHT & LICENSE

Copyright (c) 2008 Jerome Quelin, all rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

