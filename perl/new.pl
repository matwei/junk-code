#!/usr/bin/env perl
# vim: set sw=4 ts=4 et ai si:
#
use strict;
use warnings;

use Getopt::Long;
use Pod::Usage;

sub get_options {
    my $opt = {
        script => 'new.pl',
    };
    GetOptions($opt, qw(
        description=s
        email=s
        module=s
        name=s
        out=s
        script=s
        help man
    ));
    pod2usage(-exitstatus => 0, -input => \*DATA)                if $opt->{help};
    pod2usage(-exitstatus => 0, -verbose => 2, -input => \*DATA) if $opt->{man};

    if ( $opt->{module} ) {
        delete $opt->{script};
    }

    unless ( $opt->{out} ) {
        $opt->{out} = shift @ARGV || $opt->{script} || $opt->{module};
    }

    pod2usage(-exitstatus => 1, -input => \*DATA)                unless $opt->{out};

    return $opt;
} # get_options()

sub read_templates {
    my ($opt) = @_;

    while ( <DATA> ) { last if /^__DATA__$/ }
    my $templates = {};
    my ($year) = (localtime)[5];
    while ( <DATA> ) {
        my ($key,$val) = split /:/, $_, 2;
        $val =~ s/%%DESCRIPTION%%/$opt->{description}/  if $opt->{description};
        $val =~ s/%%EMAIL%%/$opt->{email}/              if $opt->{email};
        $val =~ s/%%MODULE%%/$opt->{module}/            if $opt->{module};
        $val =~ s/%%NAME%%/$opt->{name}/                if $opt->{name};
        $val =~ s/%%SCRIPT%%/$opt->{script}/            if $opt->{script};
        $val =~ s/%%YEAR%%/$year/;
        $templates->{$key} .= $val;
    }
    return $templates;
} # read_templates

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
    my $text = (exists $opt->{script}) ? $tmp->{script} : $tmp->{module};
    print $fh $text;
    close($fh)                                          unless $opt->{out} eq '-';

} # write_file()

my $opt = get_options();
my $tmp = read_templates($opt);

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

=head3 --description $description

Provide a short description to replace '%%DESCRIPTION%%' in the template.

=head3 --email $address

Provide an address to substitute '%%EMAIL%%' in the template.

=head3 --module $module_name

Provide a module name to substitute '%%MODULE%%' in the template.

This option switches the script to write a module instead a script.

=head3 -name $name

Provide a name to substute '%%NAME%%' in the template.

=head3 -out $fname

An alternative to provide the output file name.

=head3 --script $script_name

Provide a name to substitute '%%SCRIPT%%' in the template.

The default is 'new.pl'.

=head3 --help

Shows a short description.

=head3 --man

Shows the full man page.

=head1 AUTHOR

Mathias Weidner C<< mamawe@cpan.org >>

=cut
__DATA__
script:#!/usr/bin/env perl
script:# vim: set sw=4 ts=4 et ai si:
script:#
script:use strict;
script:use warnings;
script:
script:use Getopt::Long;
script:use Pod::Usage;
script:
script:sub get_options {
script:    my $opt = {};
script:    GetOptions($opt, qw(
script:        help man
script:    ));
script:    pod2usage(-exitstatus => 0, -input => \*DATA)                if $opt->{help};
script:    pod2usage(-exitstatus => 0, -verbose => 2, -input => \*DATA) if $opt->{man};
script:
script:    return $opt;
script:} # get_options()
script:
script:my $opt = get_options();
script:
script:exit 0;
script:
script:__END__
script:
script:=encoding utf8
script:
script:=head1 NAME
script:
script:%%SCRIPT%% - %%DESCRIPTION%%
script:
script:=head1 VERSION
script:
script:This man page describes version v0.0.1 of the program.
script:
script:=head1 SYNOPSIS
script:
script:  new.pl [ options ]
script:
script:=head1 OPTIONS AND ARGUMENTS
script:
script:=head2 Options
script:
script:=head3 --help
script:
script:Shows a short description.
script:
script:=head3 --man
script:
script:Shows the full man page.
script:
script:=head1 AUTHOR
script:
script:%%NAME%% C<< <%%EMAIL%%> >>
script:
module:package %%MODULE%%;
module:
module:use warnings;
module:use strict;
module:use Carp;
module:
module:use version; $VERSION = qv('0.0.1');
module:
module:# Module implementation here
module:
module:1; # Magic true value required at end of module
module:__END__
module:
module:=head1 NAME
module:
module:%%MODULE%% - %%DESCRIPTION%%
module:
module:
module:=head1 VERSION
module:
module:This document describes %%MODULE%% version 0.0.1
module:
module:
module:=head1 SYNOPSIS
module:
module:    use %%MODULE%%;
module:
module:=head1 DESCRIPTION
module:
module:
module:=head1 INTERFACE 
module:
module:=head1 DIAGNOSTICS
module:
module:=over
module:
module:=item C<< Error message here, perhaps with %s placeholders >>
module:
module:[Description of error here]
module:
module:=back
module:
module:
module:=head1 CONFIGURATION AND ENVIRONMENT
module:
module:%%MODULE%% requires no configuration files or environment variables.
module:
module:=head1 DEPENDENCIES
module:
module:None.
module:
module:=head1 INCOMPATIBILITIES
module:
module:None reported.
module:
module:=head1 BUGS AND LIMITATIONS
module:
module:No bugs have been reported.
module:
module:Please report any bugs or feature requests to
module:C<bug-app-new@rt.cpan.org>, or through the web interface at
module:L<http://rt.cpan.org>.
module:
module:
module:=head1 AUTHOR
module:
module:%%NAME%%  C<< <mamawe@cpan.org> >>
module:
module:
module:=head1 LICENCE AND COPYRIGHT
module:
module:Copyright (c) %%YEAR%%, %%NAME%% C<< <%%EMAIL%%> >>. All rights reserved.
module:
module:This module is free software; you can redistribute it and/or
module:modify it under the same terms as Perl itself. See L<perlartistic>.
module:
module:
module:=head1 DISCLAIMER OF WARRANTY
module:
module:BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
module:FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
module:OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
module:PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
module:EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
module:WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
module:ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
module:YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
module:NECESSARY SERVICING, REPAIR, OR CORRECTION.
module:
module:IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
module:WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
module:REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
module:LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
module:OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
module:THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
module:RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
module:FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
module:SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
module:SUCH DAMAGES.
