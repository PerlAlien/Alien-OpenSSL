use strict;
use warnings;
use ExtUtils::MakeMaker;
use Alien::Build::MM;
use Getopt::Long qw( GetOptions );

my $version;
GetOptions("version=s" => \$version);
my $abmm = Alien::Build::MM->new(my_openssl_version => $version);

WriteMakefile($abmm->mm_args(
  ABSTRACT     => 'Alien wrapper for OpenSSL',
  DISTNAME     => 'Alien-OpenSSL',
  NAME         => 'Alien::OpenSSL',
  VERSION_FROM => 'lib/Alien/OpenSSL.pm',
  LICENSE      => 'perl_5',
  AUTHOR       => 'Johanna Amann <johanna@icir.org>',
  META_MERGE => {
    'meta-spec' => { version => 2 },
    resources => {
      bugtracker => {
        web  => 'https://github.com/PerlAlien/Alien-OpenSSL/issues',
      },
      homepage => 'https://metacpan.org/pod/Alien::OpenSSL',
      repository => {
        type => 'git',
        url  => 'https://github.com/PerlAlien/Alien-OpenSSL.git',
        web  => 'https://github.com/PerlAlien/Alien-OpenSSL',
      },
      x_IRC => "irc://irc.perl.org/#native",
    },
  },
  "CONFIGURE_REQUIRES" => {
    "Alien::Build" => "1.30",
    "Alien::Build::MM" => "1.30",
  },
  "BUILD_REQUIRES" => {
    "Alien::Build::MM" => "1.30",
  },
  "PREREQ_PM" => {
    "Alien::Build" => "1.30",
  },
  "TEST_REQUIRES" => {
    "Test2::V0"         => "0",
    "Test::Alien::Diag" => "0",
  },
));

sub MY::postamble {
  $abmm->mm_postamble;
}
