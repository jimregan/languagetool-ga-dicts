#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

while(<>) {
	my $surface = '';
	my $lemma = '';
	my $tags = '';
	chomp;
	if($_ eq "++Num+Op\t+") {
#		print "+\t+\t+Num+Op\n";
		next;
	} else {
		if(/^([^+]*)([^\t]*)\t(.*)$/) {
			my $lemma = $1;
			my $tags = $2;
			my $surface = $3;
			# drop first '+'
			$tags =~ s/\+//;
			# replace rest with ':'
			$tags =~ s/\+/:/g;
			# filter
			next if ($tags eq 'XMLTag' || $tags eq 'Event' || $tags eq 'Num:Op');
			if ($tags eq '' || $surface eq '' || $lemma eq '') {
				print STDERR "Error in line: $_\n";
				next;
			}
			print "$surface\t$lemma\t$tags\n";
		} else {
			print STDERR "Error reading line: $_\n";
		}
	}
}
