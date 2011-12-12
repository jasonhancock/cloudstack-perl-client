#!/usr/bin/perl

use strict;
use warnings;

use CloudStack::Client;

my $cloudstack = CloudStack::Client->new( {
    'apiendpoint' => 'http://example.com:8080/client/api',
    'apikey'      => 'API KEY',
    'apisecret'   => 'API SECRET'
});

my $job = $cloudstack->deployVirtualMachine({
    'serviceofferingid' => 2,
    'templateid'        => 214,
    'zoneid'            => 2
});

print "VM being deployed. Job id = " . $job->{'jobid'} . "\n";

print "All Jobs:\n";
my $jobs = $cloudstack->listAsyncJobs({});
foreach my $job(@{$jobs}) {
    printf("%s : %s, status = %s\n", $job->{'jobid'}, $job->{'cmd'}, $job->{'jobstatus'});
}

