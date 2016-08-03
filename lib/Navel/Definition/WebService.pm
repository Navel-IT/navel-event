# Copyright (C) 2015 Yoann Le Garff, Nicolas Boquet and Yann Le Bras
# navel-base is licensed under the Apache License, Version 2.0

#-> BEGIN

#-> initialization

package Navel::Definition::WebService 0.1;

use Navel::Base;

use parent 'Navel::Base::Definition';

use Navel::API::Swagger2::Scheduler;

use Mojo::URL;

BEGIN {
    __PACKAGE__->_prepare_definition(
        'Navel::API::Swagger2::Scheduler',
        '/definitions/webservice'
    );

    __PACKAGE__->_create_setters(@{__PACKAGE__->swagger_definition()->{required}});
}

#-> methods

sub validate {
    my ($class, $raw_definition) = @_;

    $class->SUPER::validate(
        definition_class => __PACKAGE__,
        validator => $class->swagger_definition(),
        raw_definition => $raw_definition,
        if_possible_suffix_errors_with_key_value => 'name'
    );
}

sub full_name {
    __PACKAGE__ . '.' . shift->{name};
}

sub url {
    my $self = shift;

    my $url = Mojo::URL->new()->scheme(
        'http' . ($self->{tls} ? 's' : '')
    )->host(
        $self->{interface_mask}
    )->port(
        $self->{port}
    );

    for (qw/
        ca
        cert
        ciphers
        key
        verify
    /) {
        $url->query()->merge(
            $_ => $self->{$_}
        ) if defined $self->{$_};
    }

    $url;
}

# sub AUTOLOAD {}

# sub DESTROY {}

1;

#-> END

__END__

=pod

=encoding utf8

=head1 NAME

Navel::Definition::WebService

=head1 COPYRIGHT

Copyright (C) 2015 Yoann Le Garff, Nicolas Boquet and Yann Le Bras

=head1 LICENSE

navel-base is licensed under the Apache License, Version 2.0

=cut
