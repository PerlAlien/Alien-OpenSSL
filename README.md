# Alien::OpenSSL ![linux](https://github.com/PerlAlien/Alien-OpenSSL/workflows/linux/badge.svg) ![macos](https://github.com/PerlAlien/Alien-OpenSSL/workflows/macos/badge.svg)

Alien wrapper for OpenSSL

# SYNOPSIS

In your Makefile.PL:

```perl
use ExtUtils::MakeMaker;
use Alien::Base::Wrapper ();

WriteMakefile(
  Alien::Base::Wrapper->new('Alien::OpenSSL')->mm_args2(
    # MakeMaker args
    NAME => 'My::XS',
    ...
  ),
);
```

In your Build.PL:

```perl
use Module::Build;
use Alien::Base::Wrapper qw( Alien::OpenSSL !export );

my $builder = Module::Build->new(
  ...
  configure_requires => {
    'Alien::OpenSSL' => '0',
    ...
  },
  Alien::Base::Wrapper->mb_args,
  ...
);

$build->create_build_script;
```

# DESCRIPTION

This distribution provides OpenSSL so that it can be used by other
Perl distributions that are on CPAN.  It does this by first trying to
detect an existing install of OpenSSL on your system.  If found it
will use that.  If it cannot be found, the source code will be downloaded
from the internet and it will be installed in a private share location
for the use of other modules.

# SEE ALSO

[Alien](https://metacpan.org/pod/Alien), [Alien::Base](https://metacpan.org/pod/Alien::Base), [Alien::Build::Manual::AlienUser](https://metacpan.org/pod/Alien::Build::Manual::AlienUser)

# AUTHOR

Original author: Johanna Amann <johanna@icir.org>

Current maintainer: Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2012-2021 by Johanna Amann.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
