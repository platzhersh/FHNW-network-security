#! usr/bin/perl
use Socket;
$b_net = "147.86.";
for ($i=0; $i<255; $i++) {
  for ($j=0; $j<255; $j++) {
    $ipaddr = "$b_net.$i.$j";
    $name = gethostbyaddr($ipaddr, AF_INET);
    if ($name) {
      print "$ip{ip}\t${name}\n";
    }
  }
}
