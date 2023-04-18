#!/usr/bin/env perl
# vim: set sw=4 ts=4 et si ai:
#
# see also: https://stackoverflow.com/questions/4221311
#
use strict;
use warnings;
use utf8;

sub read_file {
    my $fh = shift;
    my $lines = [];

    binmode($fh, ":encoding(Latin1)");
    while (<$fh>) {
        push @$lines, $_;
    }
    return $lines;
}

sub write_file {
    my ($lines, $fh) = @_;

    binmode($fh, ":encoding(UTF-8)");
    for (@$lines) {
        print;
    }
}

if (0 < scalar @ARGV) {
    for my $fname (@ARGV) {
        # alternative (without the need for 'binmode()':
        # if (open(my $fh, "<:encoding(Latin1)", $fname)) {
        if (open(my $fh, '<', $fname)) {
            my $lines = read_file($fh);
            close($fh);
            write_file($lines,\*STDOUT);
        }
    }
}
else {
    my $lines = read_file(\*STDIN);
    write_file($lines,\*STDOUT);
}
