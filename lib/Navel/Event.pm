# Copyright (C) 2015-2017 Yoann Le Garff, Nicolas Boquet and Yann Le Bras
# navel-event is licensed under the Apache License, Version 2.0

#-> BEGIN

#-> initialization

package Navel::Event 0.1;

use Navel::Base;

use constant {
    I_TIME => 0,
    I_CLASS => 1,
    I_ID => 2,
    I_DESCRIPTION => 3,
    I_DATA => 4
};

use Navel::Utils qw/
    croak
    :json
    isint
 /;

#-> class variables

my $json_constructor = json_constructor;

#-> methods

sub deserialize {
    my ($class, $event) = (shift, $json_constructor->decode(shift));

    croak('event must be a ARRAY reference') unless ref $event eq 'ARRAY';

    $class->new(
        time => $event->[I_TIME],
        class => $event->[I_CLASS],
        id => $event->[I_ID],
        description => $event->[I_DESCRIPTION],
        data => $event->[I_DATA]
    );
}

sub new {
    my ($class, %options) = @_;

    bless {
        time => isint($options{time}) ? $options{time} : time,
        class => $options{class},
        id => $options{id} // croak('id must be defined'),
        description => $options{description},
        data => $options{data}
    }, ref $class || $class;
}

sub serialize {
    my $self = shift;

    my @event;

    $event[I_TIME] = $self->{time};
    $event[I_CLASS] = $self->{class};
    $event[I_ID] = $self->{id};
    $event[I_DESCRIPTION] = $self->{description};
    $event[I_DATA] = $self->{data};

    $json_constructor->encode(\@event);
}

# sub AUTOLOAD {}

# sub DESTROY {}

1;

#-> END

__END__

=pod

=encoding utf8

=head1 NAME

Navel::Event

=head1 COPYRIGHT

Copyright (C) 2015-2017 Yoann Le Garff, Nicolas Boquet and Yann Le Bras

=head1 LICENSE

navel-notification is licensed under the Apache License, Version 2.0

=cut
