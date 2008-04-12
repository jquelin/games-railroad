#!perl
#
# This file is part of Language::Befunge.
# Copyright (c) 2008 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
#

use strict;
use warnings;

use Test::More tests => 2;

require_ok( 'Games::RailRoad' );
diag( "Testing Games::RailRoad $Games::RailRoad::VERSION Perl $], $^X" );

require_ok( 'Games::RailRoad::Train' );

exit;
