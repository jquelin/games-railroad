#!perl
#
# This file is part of Games::RailRoad.
# Copyright (c) 2008 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
#

BEGIN { require 5.010; }
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Games::RailRoad',
    AUTHOR              => 'Jerome Quelin <jquelin@cpan.org>',
    LICENSE             => 'perl',
    VERSION_FROM        => 'lib/Games/RailRoad.pm',
    ABSTRACT_FROM       => 'lib/Games/RailRoad.pm',
    EXE_FILES           => [ 'bin/railsim' ],
    PREREQ_PM => {
        'Class::Accessor::Fast' => 0,
        'File::Basename'        => 0,
        'File::HomeDir'         => 0,
        'File::Path'            => 0,
        'File::Spec::Functions' => 0,
        'Getopt::Euclid'        => 0,
        'Module::Pluggable'     => 0,
        'POE'                   => 0,
        'Readonly'              => 0,
        'Test::More'            => 0,
        'Tk'                    => 0,
        'Tk::PNG'               => 0,
        'Tk::ToolBar'           => 0,
        'UNIVERSAL::require'    => 0,
        'YAML'                  => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => [
                'Games-RailRoad-*', 'MANIFEST.bak',
                map { ( '*/' x $_ ) . '*~' } 0..5
        ] },
);
