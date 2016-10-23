# Copyright (C) 2015-2016 Yoann Le Garff, Nicolas Boquet and Yann Le Bras
# navel-event is licensed under the Apache License, Version 2.0

#-> BEGIN

#-> initialization

package Navel::Event::Status 0.1;

use Navel::Base;

use Navel::Utils qw/
    croak
    isint
 /;

#-> class variables

our %STATUS = (
    std => 0
);

#-> methods

sub reverse {
    my ($class, $value) = @_;

    croak('value must be an integer') unless isint($value);

    my $label;

    for (keys %STATUS) {
        if ($value == $STATUS{$_}) {
            $label = $_;

            last;
        }
    }

    $label;
}

sub new {
    my ($class, $value) = @_;

    my $self = bless {}, ref $class || $class;

    $self->set(defined $value ? $value : $STATUS{std});

    $self;
}

sub set {
    my ($self, $value) = @_;

    if (isint($value)) {
        $value = $self->reverse($value);

        die "invalid status\n" unless defined $value;
    } else {
        die "invalid status\n" unless defined $value && exists $STATUS{$value};
    }

    $self->{value} = $STATUS{$value};

    $self;
}

# sub AUTOLOAD {}

# sub DESTROY {}

1;

#-> END

__END__

=pod

=encoding utf8

=head1 NAME

Navel::Event::Status

=head1 COPYRIGHT

Copyright (C) 2015-2016 Yoann Le Garff, Nicolas Boquet and Yann Le Bras

=head1 LICENSE

navel-event is licensed under the Apache License, Version 2.0

=cut
