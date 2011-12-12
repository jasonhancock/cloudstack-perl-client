#!/usr/bin/perl

use strict;
use warnings;

use CloudStack::Client;

my $cloudstack = CloudStack::Client->new( {
    'apiendpoint' => 'http://example.com:8080/client/api',
    'apikey'      => 'API KEY',
    'apisecret'   => 'SECRET KEY'
});

my $vms = $cloudstack->listVirtualMachines({});

foreach my $vm(@{$vms}) {
    printf("%s %s %s\n", $vm->{'id'}, $vm->{'name'}, $vm->{'state'});
}
