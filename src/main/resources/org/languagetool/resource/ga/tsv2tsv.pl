#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

while(<>) {
	chomp;
	if($_ eq "++Num+Op\t+") {
		print "+\t+\t+Num+Op\n";
	} else {
		if(/^([^+]*)([^\t]*)\t(.*)$/) {
			print "$3\t$1\t$2\n";
		} else {
			print STDERR "Error reading line: $_\n";
		}
	}
}
