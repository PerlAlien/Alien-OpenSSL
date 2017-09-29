use strict;
use warnings;
use ExtUtils::MakeMaker;
use Alien::Build::MM;
use Getopt::Long qw( GetOptions );

my $version;
GetOptions("version=s" => \$version);
my $abmm = Alien::Build::MM->new(my_openssl_version => $version);

WriteMakefile($abmm->mm_args(
	SIGN         => 1,
	ABSTRACT     => 'Alien wrapper for OpenSSL',
	DISTNAME     => 'Alien-OpenSSL',
	NAME         => 'Alien::OpenSSL',
	VERSION_FROM => 'lib/Alien/OpenSSL.pm',
	LICENSE      => 'perl_5',
	AUTHOR       => 'Johanna Amann <johanna@icir.org>',
	META_MERGE => {
		resources => {
			homepage => 'https://github.com/0xxon/alien-openssl',
			bugtracker => 'https://github.com/0xxon/alien-openssl/issues',
			repository  => 'git://github.com/0xxon/alien-openssl.git',
		},
	},
));

sub MY::postamble {
  $abmm->mm_postamble;
}
