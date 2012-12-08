use strict;
use warnings;

use Alien::Base::ModuleBuild;

my $builder = Alien::Base::ModuleBuild->new (
	module_name => 'Alien::OpenSSL',
	license => 'perl',
	configure_requires => {
		'Alien::Base' => '0.001',
		'Module::Build' => '0.38',
	},
	requires => {
		'perl' => '5.8.1',
		'Alien::Base' => 0,
	},
	dist_author => 'Johanna Amann <johanna@icir.org>',
	alien_name => 'openssl',
	alien_repository => {
		protocol => 'ftp',
		host => 'ftp.openssl.org',
		location => '/source/',
		pattern  => qr/^openssl-([\d\.]+\w?).tar\.gz$/,
	},
	alien_build_commands => [ 
		'%pconfig --prefix=%s', 
		'make', 
		'make test',
		'rm -f libcrypto.pc libssl.pc'	# only leave openssl.pc to be picked up by alien
		],
	alien_install_commands => [
		'make install',
		'rm -f libcrypto.pc libssl.pc'  # only leave openssl.pc to be picked up by alien
		],
);


$builder->create_build_script;
