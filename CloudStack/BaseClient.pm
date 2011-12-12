#!/usr/bin/perl

use strict;
use warnings;

package CloudStack::BaseClient;

use URI::Escape;
use MIME::Base64;
use Digest::SHA qw(hmac_sha1);
use LWP::UserAgent;
use JSON;
use Data::Dumper;

sub new {
    my ($class) = shift;

    my ($args) = @_;

    my $self={
            apiendpoint => $args->{apiendpoint},
            apikey      => $args->{apikey},
            apisecret   => $args->{apisecret},
        };

    bless $self, $class;

    return $self;
}

sub request {
    my ($self, $command, $args) = @_;

    foreach my $key(keys %{$args}) {
        if(length($args->{$key}) == 0) {
            delete $args->{$key};
        }
    }

    $args->{'apikey'}   = $self->{'apikey'};
    $args->{'command'}  = $command;
    $args->{'response'} = 'json';

    my @params;

    foreach my $key(sort keys %{$args}) {
        push(@params, "$key=" . uri_escape($args->{$key}));    
    }
    
    my $query = join('&', @params);
    my $digest = hmac_sha1(lc($query), $self->{apisecret});
    my $base64_encoded = encode_base64($digest);chomp($base64_encoded);
    my $url_encoded = uri_escape($base64_encoded);
    $query .= "&signature=$url_encoded";

    my $url = $self->{apiendpoint} . '?' . $query;

    $self->{ua} = new LWP::UserAgent if !defined($self->{ua});
    my $response = $self->{ua}->get($url);
    #if(!$response->is_success) {
        # TODO: exception instead....
    #    die($response->status_line . "\n");
    #}

    my $json = JSON->new->allow_nonref;
    my $decoded = $json->decode( $response->content ); #TODO: catch croak?

    my $propertyResponse = lc($args->{'command'}) . 'response';
    
    if(!defined($decoded->{$propertyResponse})) {
        if(defined($decoded->{'errorresponse'})) {
            die("ERROR: " . $decoded->{'errorresponse'}->{'errortext'});
        } else {
            die("Unable to parse the response " . $response->status_line); 
        }
    }

    $response = $decoded->{$propertyResponse};

    if(lc($args->{'command'})=~m/list(\w+)s/) {
        my $type = $1;

        if(defined($response->{$type})) {
            return $response->{$type};
        } else {
            # sometimes, the 's' is kept, as in :
            # { "listasyncjobsresponse" : { "asyncjobs" : [ ... ] } }
            $type = $type . 's';
            if(defined($response->{$type})) {
                return $response->{$type};
            }
        }
    }

    return $response;
}

1;
