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

use Games::RailRoad::Node;
use Games::RailRoad::Train;
use Readonly;
use Tk; # should come before POE
use Tk::ToolBar;
use POE;


our $VERSION = '0.02';

Readonly my $NBCOLS  => 60;
Readonly my $NBROWS  => 40;
Readonly my $TILELEN => 20;    # in pixels
Readonly my $TICK    => 0.050; # in seconds

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
            _tick            => \&_on_tick,
            # gui events
            _b_quit          => \&_on_b_quit,
            _c_b1_dblclick   => \&_on_c_b1_dblclick,
            _c_b1_motion     => \&_on_c_b1_motion,
            _c_b1_press      => \&_on_c_b1_press,
            _c_b2_press      => \&_on_c_b2_press,
            _c_b3_press      => \&_on_c_b3_press,
        },
        args => \%opts,
    );
    return $session->ID;
}


# -- PUBLIC EVENTS


# -- PRIVATE EVENTS

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
        #[ 'Button', 'fileopen16',       'open',        '<Control-o>', '_b_open' ],
        #[ 'separator' ],
        #[ 'Button', 'calbell16',        'breakpoints', '<F8>',        '_b_breakpoints' ],
        #[ 'separator' ],
        #[ 'Button', 'playstart16',      'restart',     '<R>',         '_b_restart' ],
        #[ 'Button', 'playpause16',      'pause',       '<p>',         '_b_pause' ],
        #[ 'Button', 'nav1rightarrow16', 'next',        '<n>',         '_b_next' ],
        #[ 'Button', 'nav2rightarrow16', 'continue',    '<c>',         '_b_continue' ],
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
    $h->{w}{canvas} = $c;

    # binding canvas events.
    my %event = (
        '<B1-Motion>'            => '_c_b1_motion',
        '<Double-ButtonPress-1>' => '_c_b1_dblclick',
        '<ButtonPress-1>'        => '_c_b1_press',
        '<ButtonPress-2>'        => '_c_b2_press',
        '<ButtonPress-3>'        => '_c_b3_press',
    );
    $c->CanvasBind($_ , [$s->postback($event{$_}), Ev('x'), Ev('y')] )
        foreach keys %event;

    # -- various heap initializations
    $h->{nodes} = {};
    #$h->{graph} = Graph->new( undirected => 1 );
    $h->{train} = undef;
    #$k->yield( $opts->{file} ? ('_open_file', $opts->{file}) : '_b_open' );

    #
    $k->delay_set( '_tick', $TICK );
}


sub _on_tick {
    my ($k, $h) = @_[KERNEL, HEAP];

    $k->delay_set( '_tick', $TICK );
    my $train = $h->{train};
    return unless defined $train;

    my $frac = $train->frac;
    $frac += 1/5;
    if ( $frac >= 1 ) {
        # eh, changing node.
        $frac -= 1;
        my $from = $train->from;
        my $to   = $train->to;

        my ($fcol, $frow) = split /,/, $from;
        my ($tcol, $trow) = split /,/, $to;

        my $dcol = $fcol-$tcol;
        my $drow = $frow-$trow;
        my $move = "$dcol,$drow";
        my $dir  = _dir_coords($move);

        my $next = $h->{nodes}{$to}->next_dir($dir);
        return unless defined $next; # dead-end
        $move = _dir_coords($next);
        ($dcol, $drow) = split /,/, $move;

        my ($col, $row) = split /,/, $to;
        $col += $dcol;
        $row += $drow;
        $train->from($to);
        $train->to("$col,$row");
    }

    $train->frac($frac);
    $train->draw( $h->{w}{canvas}, $TILELEN );
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
# _on_c_b1_dblclick( [], [$stuff, $x, $y] );
#
# called when double-clicking left button. switch the node if possible
# (Games::RailRoad::Node::Switch).
#
sub _on_c_b1_dblclick {
    my ($k,$h, $args) = @_[KERNEL, HEAP, ARG1];
    my (undef, $x, $y) = @$args;

    # resolve column & row.
    my ($pos, $col, $row) = _resolve_coords($x,$y,0.5);
    my $node = $h->{nodes}{$pos};
    return unless defined($node);

    # switch the exits.
    $node->switch;
    $node->draw($h->{w}{canvas}, $TILELEN);
}


#
# _on_c_b1_motion( [], [$stuff, $x, $y] );
#
# called when the mouse is moving on canvas while button is down.
#
sub _on_c_b1_motion {
    my ($k,$h, $args) = @_[KERNEL, HEAP, ARG1];
    my (undef, $x, $y) = @$args;

    # resolve column & row.
    my ($newpos, $newcol, $newrow) = _resolve_coords($x,$y,2/5);
    my ($oldpos, $oldcol, $oldrow) = @{ $h->{position} };

    # basic checks.
    return unless defined $newpos;                     # new position is undef
    return if defined($oldpos) && $oldpos eq $newpos;  # we did not move

    # we moved: store new position & create new node.
    $h->{position} = [$newpos, $newcol, $newrow];
    if ( not exists $h->{nodes}{$newpos} ) {
        my $n = Games::RailRoad::Node->new({col=>$newcol,row=>$newrow});
        $h->{nodes}{$newpos} = $n;
    }
    my $newnode = $h->{nodes}{$newpos};

    # try to resolve old position.
    return unless defined $oldpos;
    my $oldnode = $h->{nodes}{$oldpos};

    # check if the move is a single segment.
    my $movex = $newcol - $oldcol;
    my $movey = $newrow - $oldrow;
    my $newmove = join ',',  $movex,  $movey;
    my $oldmove = join ',', -$movex, -$movey;
    my $newdir = _dir_coords( $newmove );
    my $olddir = _dir_coords( $oldmove );
    if ( not defined $newdir ) {
        warn "cannot move according to ($newmove)\n";
        return;
    }

    # check if we can morph the nodes with this move.
    return unless $oldnode->connectable($newdir)
        && $newnode->connectable($olddir);
    $oldnode->connect($newdir);
    $newnode->connect($olddir);

    # redraw the 2 nodes.
    $oldnode->draw( $h->{w}{canvas}, $TILELEN );
    $newnode->draw( $h->{w}{canvas}, $TILELEN );
}


#
# _on_c_b1_press( [], [$stuff, $x, $y] );
#
# called when the button mouse is pressed on canvas.
#
sub _on_c_b1_press {
    my ($k,$h, $args) = @_[KERNEL, HEAP, ARG1];
    my (undef, $x, $y) = @$args;

    # resolve column & row.
    my ($pos, $col, $row) = _resolve_coords($x,$y,2/5);

    # store current position - even undef.
    $h->{position} = [$pos, $col, $row];

    # create the node if possible.
    return unless defined $pos;
    return if defined $h->{nodes}{$pos};
    my $node = Games::RailRoad::Node->new({col=>$col,row=>$row});
    $h->{nodes}{$pos} = $node;
}


#
# _on_c_b2_press( [], [$stuff, $x, $y] );
#
# called when the right-button mouse is pressed on canvas. this will
# place a new train.
#
sub _on_c_b2_press {
    my ($h, $args) = @_[HEAP, ARG1];
    my (undef, $x, $y) = @$args;

    return if defined $h->{train}; # only one train

    my ($pos, $col, $row) = _resolve_coords($x,$y,0.5);

    # check if there's a rail at $pos.
    if ( not exists $h->{nodes}{$pos} ) {
        warn "no rail at ($pos)\n";
        return;
    }

    # pick a random dir at first.
    my @dirs = $h->{nodes}{$pos}->connections;
    if ( scalar @dirs == 0 ) {
        warn "nowhere to move on\n";
        return;
    }
    my $dir  = $dirs[ rand @dirs ];
    my $move = _dir_coords($dir);
    my ($dcol, $drow) = split /,/, $move;
    $col += $dcol;
    $row += $drow;
    my $to = "$col,$row";

    # create the train.
    $h->{train} = Games::RailRoad::Train->new( {
        from => $pos,
        to   => $to,
        frac => 0,
    } );
    $h->{train}->draw( $h->{w}{canvas}, $TILELEN );
}


#
# _on_c_b3_press( [], [$stuff, $x, $y] );
#
# called when the right-button mouse is pressed on canvas. this will
# mark the beginning corner of the delete area.
#
sub _on_c_b3_press {
    my ($h, $args) = @_[HEAP, ARG1];
    my (undef, $x, $y) = @$args;
    my ($pos, $col, $row) = _resolve_coords($x,$y,0.5);

    my $node = $h->{nodes}{$pos};
    return unless defined $node;

    # check if we can remove connection
    my @connections = sort $node->connections;
    foreach my $dir ( @connections ) {
        my ($dcol, $drow) = split /,/, _dir_coords($dir);
        my $col2 = $col + $dcol;
        my $row2 = $row + $drow;
        my $n = $h->{nodes}{"$col2,$row2"};
        $dcol = -$dcol;
        $drow = -$drow;
        my $dir2 = _dir_coords("$dcol,$drow");

        if ( ! $n->connectable("-$dir2") ) {
            warn "($col2,$row2) cannot be disconnected from ($pos) - $dir2\n";
            return;
        }
    }

    # remove the connections
    foreach my $dir ( @connections ) {
        my ($dcol, $drow) = split /,/, _dir_coords($dir);
        my $col2 = $col + $dcol;
        my $row2 = $row + $drow;
        my $n = $h->{nodes}{"$col2,$row2"};
        $dcol = -$dcol;
        $drow = -$drow;
        my $dir2 = _dir_coords("$dcol,$drow");
        $n->connect( "-$dir2" );
        $n->draw( $h->{w}{canvas}, $TILELEN );
    }

    $node->delete( $h->{w}{canvas} );
    delete $h->{nodes}{$pos};
}


# -- PRIVATE SUBS

#
# my $coords = _dir_coords( $dir );
# my $dir    = _dir_coords( $coords );
#
# given a direction ('n', 'se', etc.) or some coords ('1,-1', '0,1',
# etc.), return the corresponding coords or (resp.) dir.
#
sub _dir_coords {
    my @dirs = (
        '-1,-1' => 'nw',
        '-1,0'  => 'w',
        '-1,1'  => 'sw',
        '0,-1'  => 'n',
        '0,1'   => 's',
        '1,-1'  => 'ne',
        '1,0'   => 'e',
        '1,1'   => 'se',
    );
    my %dir = ( @dirs, reverse @dirs );
    return $dir{ $_[0] };
}


#
# my ($pos, $col, $row) = _resolve_coords($x, $y, $precision);
#
# the canvas deals with pixels: this sub transforms canvas coordinates
# ($x,$y) in the $col and $row of the matching node.
#
# if we're not close enough of a node (within a square of $TILELEN times
# $precision), precision is not enough: $pos will be undef.
#
# $pos is the string "$col-$row".
#
#
sub _resolve_coords {
    my ($x, $y, $prec) = @_;

    my $col = int( $x/$TILELEN );
    my $row = int( $y/$TILELEN );

    # if we're in the middle of two nodes, it's not precise enough.
    $x %= $TILELEN;
    $y %= $TILELEN;
    given ($x) {
        when( $_ > $TILELEN * (1-$prec) ) { $col++; }
        when( $_ < $TILELEN * $prec     ) { } # nothing to do
        default { return; }                   # not precise enough
    }
    given ($y) {
        when( $_ > $TILELEN * (1-$prec) ) { $row++; }
        when( $_ < $TILELEN * $prec     ) { } # nothing to do
        default { return; }                   # not precise enough
    }

    return ("$col,$row", $col, $row);
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



=head1 TODO

Currently the module is very rough and supports very few operations:

=over 4

=item * drawing and connecting rails by left-clicking and dragging mouse
on the canvas.

=item * removing a node by right-clicking on it on the canvas.

=item * placing a train on a rail by middle-clikcing on a rail on the canvas.

=item * changing switch exits by double-clicking on it.

=back


The amount of work needed is much more vast and includes (but not
limited to):

=over 4

=item * support for more than one train

=item * adding coaches to trains

=item * fixing speed change in diagonal rails

=item * saving / loading to a file

=item * rc-file for the application

=item * better interface (what about one-button mice?)

=item * available help

=item * etc...

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

