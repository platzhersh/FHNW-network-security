#!/usr/bin/perl -w
### port_scan.pl
### Author: Avi Kak (kak@purdue.edu)
use strict;
use IO::Socket;
## Usage example:
##
## port_scan.pl www.fhnw.ch 1 1024
## or
## port_scan.pl 10.X.Y.Z 1 1024
##
my $verbosity = 0; # Set to 1 if you want to see the result for each port
# separately
die "Usage: port_scan.pl host start_port end_port " .
"\n where \n host is the symbolic hostname or the IP " .
"address of the machine whose ports you want to scan " .
"\n start_port is the starting port number and " .
"\n end_port is the ending port number"
unless @ARGV == 3;
my $dst_host = shift;
my $start_port = shift;
my $end_port = shift;
my @open_ports = ();
my $testport;
# Autoflush the output supplied to print
$|++;
# Scan the ports in the specified range:
for ($testport=$start_port; $testport <= $end_port; $testport++) {
my $sock = IO::Socket::INET->new(PeerAddr => $dst_host,
PeerPort => $testport,
Timeout => "0.1",
Proto => 'tcp');
if ($sock) {
push @open_ports, $testport;
print "Open Port: ", $testport, "\n" if $verbosity == 1;
print " $testport " if $verbosity == 0;
} else {
print "Port closed: ", $testport, "\n" if $verbosity == 1;
print "." if $verbosity == 0;
}
}
#
# Was wird hier gemacht?
#
my %service_ports;
if (-s "/etc/services" ) {
open IN, "/etc/services";
while (<IN>) {
chomp;
# Get rid of the comment lines in the file:
next if $_ =~ /^\s*#/;
my @entry = split;
$service_ports{ $entry[1] } = join " ",
split /\s+/, $_ if $entry[1];
}
close IN;
}
open OUT, ">openports.txt"
or die "Unable to open openports.txt: $!";
if (!@open_ports) {
print "\n\nNo open ports in the range specified\n";
} else {
print "\n\nThe open ports:\n\n";
foreach my $k (0..$#open_ports) {
if (-s "/etc/services" ) {
foreach my $portname ( sort keys %service_ports ) {
if ($portname =~ /^$open_ports[$k]\//) {
print "$open_ports[$k]: $service_ports{$portname}\n";
}
}
} else {
print $open_ports[$k], "\n";
}
print OUT $open_ports[$k], "\n";
}
}
close OUT;
print "\n";
