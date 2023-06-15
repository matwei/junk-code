#!/usr/bin/env perl
# vim: set sw=4 ts=4 et ai si:
#
use strict;
use warnings;

use Getopt::Long;
use Pod::Usage;

sub get_options {
    my $opt = {
    };
    GetOptions($opt, qw(
        email=s
        name=s
        out=s
        help man
    ));
    pod2usage(-exitstatus => 0, -input => \*DATA)                if $opt->{help};
    pod2usage(-exitstatus => 0, -verbose => 2, -input => \*DATA) if $opt->{man};

    unless ( $opt->{out} ) {
        $opt->{out} = shift @ARGV;
    }

    pod2usage(-exitstatus => 1, -input => \*DATA)                unless $opt->{out};

    return $opt;
} # get_options()

sub read_template {
    my ($opt) = @_;

    while ( <DATA> ) { last if /^__DATA__$/ }
    my $template = "";
    while ( <DATA> ) {
        my ($key,$val) = split /:/, $_, 2;
        $val =~ s/%%EMAIL%%/$opt->{email}/      if $opt->{email};
        $val =~ s/%%NAME%%/$opt->{name}/        if $opt->{name};
        $template .= $val;
    }
    return $template;
} # read_template

sub write_file {
    my ($opt, $tmp) = @_;
    my $fh;

    if ( $opt->{out} eq '-' ) {
        $fh = \*STDOUT;
    }
    else {
        die "File '$opt->{out}' exists!"                if -f $opt->{out};
        open($fh, '>', $opt->{out})
            or die "Can't write to '$opt->{out}': $!";
    }
    print $fh $tmp;
    close($fh)                                          unless $opt->{out} eq '-';

} # write_file()

my $opt = get_options();
my $tmp = read_template($opt);

write_file($opt, $tmp);

exit 0;

__END__

=encoding utf8

=head1 NAME

new.pl - create a new Perl script

=head1 VERSION

This man page describes version v0.0.1 of the program.

=head1 SYNOPSIS

  new.pl [ options ] filename

=head1 OPTIONS AND ARGUMENTS

=head2 Options

=head3 --email $address

Provide an address to substitute '%%EMAIL%%' in the template.

=head3 -name $name

Provide a name to substute '%%NAME%%' in the template.

=head3 -out $fname

An alternative to provide the output file name.

=head3 --help

Shows a short description.

=head3 --man

Shows the full man page.

=head1 AUTHOR

Mathias Weidner C<< mamawe@cpan.org >>

=cut
__DATA__
template:#!/usr/bin/env perl
template:# vim: set sw=4 ts=4 et ai si:
template:#
template:use strict;
template:use warnings;
template:
template:use Getopt::Long;
template:use Pod::Usage;
template:
template:sub get_options {
template:    my $opt = {};
template:    GetOptions($opt, qw(
template:        help man
template:    ));
template:    pod2usage(-exitstatus => 0, -input => \*DATA)                if $opt->{help};
template:    pod2usage(-exitstatus => 0, -verbose => 2, -input => \*DATA) if $opt->{man};
template:
template:    return $opt;
template:} # get_options()
template:
template:my $opt = get_options();
template:
template:exit 0;
template:
template:__END__
template:
template:=encoding utf8
template:
template:=head1 NAME
template:
template:new.pl - create a new Perl script
template:
template:=head1 VERSION
template:
template:This man page describes version v0.0.1 of the program.
template:
template:=head1 SYNOPSIS
template:
template:  new.pl [ options ]
template:
template:=head1 OPTIONS AND ARGUMENTS
template:
template:=head2 Options
template:
template:=head3 --help
template:
template:Shows a short description.
template:
template:=head3 --man
template:
template:Shows the full man page.
template:
template:=head1 AUTHOR
template:
template:%%NAME%% C<< %%EMAIL%% >>
template:
