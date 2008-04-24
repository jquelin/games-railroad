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

use Test::More tests => 49;

require_ok( 'Games::RailRoad' );
diag( "Testing Games::RailRoad $Games::RailRoad::VERSION Perl $], $^X" );

require_ok( 'Games::RailRoad::Node' );
require_ok( 'Games::RailRoad::Node::Cross' );
require_ok( 'Games::RailRoad::Node::Cross::E_NE_SW_W' );
require_ok( 'Games::RailRoad::Node::Cross::E_NW_SE_W' );
require_ok( 'Games::RailRoad::Node::Cross::N_NE_S_SW' );
require_ok( 'Games::RailRoad::Node::Cross::N_NW_S_SE' );
require_ok( 'Games::RailRoad::Node::Half' );
require_ok( 'Games::RailRoad::Node::Half::E' );
require_ok( 'Games::RailRoad::Node::Half::N' );
require_ok( 'Games::RailRoad::Node::Half::NE' );
require_ok( 'Games::RailRoad::Node::Half::NW' );
require_ok( 'Games::RailRoad::Node::Half::S' );
require_ok( 'Games::RailRoad::Node::Half::SE' );
require_ok( 'Games::RailRoad::Node::Half::SW' );
require_ok( 'Games::RailRoad::Node::Half::W' );
require_ok( 'Games::RailRoad::Node::Straight' );
require_ok( 'Games::RailRoad::Node::Straight::E_NW' );
require_ok( 'Games::RailRoad::Node::Straight::E_SW' );
require_ok( 'Games::RailRoad::Node::Straight::E_W' );
require_ok( 'Games::RailRoad::Node::Straight::NE_S' );
require_ok( 'Games::RailRoad::Node::Straight::NE_SW' );
require_ok( 'Games::RailRoad::Node::Straight::NE_W' );
require_ok( 'Games::RailRoad::Node::Straight::NW_S' );
require_ok( 'Games::RailRoad::Node::Straight::NW_SE' );
require_ok( 'Games::RailRoad::Node::Straight::N_S' );
require_ok( 'Games::RailRoad::Node::Straight::N_SE' );
require_ok( 'Games::RailRoad::Node::Straight::N_SW' );
require_ok( 'Games::RailRoad::Node::Straight::SE_W' );
require_ok( 'Games::RailRoad::Node::Switch' );
require_ok( 'Games::RailRoad::Node::Switch::E_NE_SW' );
require_ok( 'Games::RailRoad::Node::Switch::E_NE_W' );
require_ok( 'Games::RailRoad::Node::Switch::E_NW_SE' );
require_ok( 'Games::RailRoad::Node::Switch::E_NW_W' );
require_ok( 'Games::RailRoad::Node::Switch::E_SE_W' );
require_ok( 'Games::RailRoad::Node::Switch::E_SW_W' );
require_ok( 'Games::RailRoad::Node::Switch::NE_SW_W' );
require_ok( 'Games::RailRoad::Node::Switch::NE_S_SW' );
require_ok( 'Games::RailRoad::Node::Switch::NW_SE_W' );
require_ok( 'Games::RailRoad::Node::Switch::NW_S_SE' );
require_ok( 'Games::RailRoad::Node::Switch::N_NE_S' );
require_ok( 'Games::RailRoad::Node::Switch::N_NE_SW' );
require_ok( 'Games::RailRoad::Node::Switch::N_NW_S' );
require_ok( 'Games::RailRoad::Node::Switch::N_NW_SE' );
require_ok( 'Games::RailRoad::Node::Switch::N_S_SE' );
require_ok( 'Games::RailRoad::Node::Switch::N_S_SW' );
require_ok( 'Games::RailRoad::Node::Temp' );
require_ok( 'Games::RailRoad::Train' );
require_ok( 'Games::RailRoad::Vector' );

exit;
