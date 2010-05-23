#!/usr/bin/perl
my $user = "OSSO";
my $pass = "______";

open STDIN, "</proc/cpuinfo";

my %p;
my $v;
$p{Processor} = sub {
	substr($pass, 5, 1) = uc substr($v, 0, 1);
	substr($pass, 2, 1) = uc substr($v, 23, 1);
};
$p{"CPU architecture"} = sub {
	substr($pass, 0, 1) = substr($v, -1, 1);
};
$p{Hardware} = sub {
	substr($pass, 1, 1) = uc substr($v, 1, 1);
	$v =~ m/^(\w+)\s(.*)$/;
	my ($Brand, $Model) = ($1, $2);
	$Brand = uc $Brand;
	$Model =~ s/^N8([01])0$/'RX-'.($1+3).'4'/e;
	$user = "${Brand}-${user}-$Model";
};
$p{Features} = sub {
	my @f = split /\s/, $v;
	my $c;
	for (@f) {
		substr($pass, 3, 1) = substr(uc, 0, 1) if 2 == ++$c;
		next unless length == 8;
		substr($pass, 4, 1) = uc substr($_, 5, 1);
		return;
	}
};

while(<>) {
	m/^([^:]+?)\s*\:\s?(.*)$/;
	my $n;
	($n, $v) = ($1, $2);
	my $f = $p{$n};
	next if not defined $f;
	$f->();
}

if ($pass =~ m/\_/) {
	die <<EOF
Failed to generate password.
You can only run this on an authentic N8x0.
EOF
}

print "Please add this line to /etc/portage/mirrors :\n";
print "\tn8x0\thttp://${user}:${pass}\@catalogue.tableteer.nokia.com/\n";
