# Copyright (C) 2015 Yoann Le Garff, Nicolas Boquet and Yann Le Bras
# navel-event is licensed under the Apache License, Version 2.0

#-> BEGIN

#-> initialization

use strict;
use warnings;

use Test::More tests => 2;
use Test::Exception;

BEGIN {
    use_ok('Navel::Definition::Publisher::Parser');
}

#-> main

my $publishers_definitions_path = 't/02-publishers.yml';

lives_ok {
    Navel::Definition::Publisher::Parser->new()->read(
        file_path => $publishers_definitions_path
    )->make();
} 'making configuration from ' . $publishers_definitions_path;

#-> END

__END__
