# Copyright (C) 2015-2016 Yoann Le Garff, Nicolas Boquet and Yann Le Bras
# navel-event is licensed under the Apache License, Version 2.0

#-> BEGIN

#-> initialization

use strict;
use warnings;

use Test::More tests => 3;
use Test::Exception;

BEGIN {
    use_ok('Navel::Event');
}

#-> main

my $event;

lives_ok {
    $event = Navel::Event->new(
        id => 't'
    );
} 'making the event';

lives_ok {
    $event->deserialize($event->serialize);
} 'serialize and deserialize the event';

#-> END

__END__
