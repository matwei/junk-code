#!/usr/bin/env perl
# vim: set sw=4 ts=4 et si ai:
# see also: https://stackoverflow.com/questions/57324506
#
# This reads a CSV file from STDIN and writes it to STDOUT.
#
# If there is given any argument on the command line,
# the order of the columns will be reverted.

use strict;
use warnings;

use Text::CSV qw();

my $csv_in = Text::CSV->new({binary => 1, auto_diag => 1});
my $csv_out = Text::CSV->new({binary => 1, auto_diag => 1});

my @headers = $csv_in->header(\*STDIN);
@headers = sort { $b cmp $a } @headers if (scalar @ARGV);

$csv_out->say(\*STDOUT, [@headers]);
while (my $row = $csv_in->getline_hr(\*STDIN)) {
    $csv_out->say(\*STDOUT, [$row->@{@headers}]);
}
