#!/usr/bin/perl
# DNS print
# Print DNS Response to console
# 11/02/2014
use strict; use warnings;
use Net::DNS;

my $target = shift || die("Specify target\n");
my $resolver = new Net::DNS::Resolver();

# Perform a lookup, using the searchlist if appropriate.
my $reply = $resolver->search( $target );

print $reply->print."\n";

