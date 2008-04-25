#!perl
#
# This file is part of Games::RailRoad.
# Copyright (c) 2008 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
#

use strict;
use warnings;

use Module::Build;
my %requires = (
    'Class::Accessor::Fast' => 0,
    'File::Basename'        => 0,
    'File::HomeDir'         => 0,
    'File::Path'            => 0,
    'File::Spec::Functions' => 0,
    'Getopt::Euclid'        => 0,
    'Module::Pluggable'     => 0,
    'POE'                   => 0,
    'Readonly'              => 0,
    'Tk'                    => 0,
    'Tk::PNG'               => 0,
    'Tk::ToolBar'           => 0,
    'Tk::ToolBar'           => 0,
    'UNIVERSAL::require'    => 0,
    'YAML'                  => 0,
    'perl'                  => '5.010',
);
my $builder = Module::Build->new
  ( module_name       => 'Games::RailRoad',
    license           => 'perl',
    dist_author       => 'Jerome Quelin <jquelin@cpan.org>',
    dist_version_from => 'lib/Games/RailRoad.pm',
    build_requires    => {
        %requires,
        'Test::More'            => 0,
    },
    requires          => \%requires,
    recommends        => {
        'Test::Pod'           => 0,
        'Test::Pod::Coverage' => 0,
    },
    script_files      => [ 'bin/railsim' ],
    add_to_cleanup    =>
      [ 'Games-RailRoad-*', 'MANIFEST.bak',
        map { ( '*/' x $_ ) . '*~' } 0..5 ],
    #recursive_test_files => 1
  );
$builder->create_build_script;

