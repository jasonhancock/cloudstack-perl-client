CloudStack PERL Client
======================

PERL client library for the CloudStack User API v2.2 (Reference : http://download.cloud.com/releases/2.2.0/api_2.2.12/TOC_Global_Admin.html). Generated using the [cloudstack-client-generator](https://github.com/jasonhancock/cloudstack-client-generator).

Examples
--------

List all virtual machines

```perl
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
```


   
Asynchronous tasks

```perl
#!/usr/bin/perl

use strict;
use warnings;

use CloudStack::Client;

my $cloudstack = CloudStack::Client->new( {
    'apiendpoint' => 'http://example.com:8080/client/api',
    'apikey'      => 'API KEY',
    'apisecret'   => 'SECRET KEY'
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
```

TODO:
-----
There is a lot to do to clean up the code and make it worthy of production. This
was just a rough first pass.
