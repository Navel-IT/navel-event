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
        collector => {
            name => 'test-1',
            collection => 'test',
            backend => 'Navel::Collector::Test',
            backend_input => undef,
            publisher => {
                backend => 'Navel::Broker::Client::Fork::Publisher::Backend::Test',
                backend_input => undef,
                auto_clean => 0
            }
        }
    );
} 'making the event';

lives_ok {
    $event->deserialize($event->serialize());
} 'serialize and deserialize the event';

#-> END

__END__
