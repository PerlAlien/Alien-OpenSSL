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
		'%pconfig shared --prefix=%s', 
		'make', 
		'make test',
		'rm -f libcrypto.pc libssl.pc'	# only leave openssl.pc to be picked up by alien
		],
	alien_install_commands => [
		'if [ -f \'config\' ]; then make install_sw; fi', # if ! config, we should be system.
		'rm -f libcrypto.pc libssl.pc'  # only leave openssl.pc to be picked up by alien
		],
	meta_merge => {
		resources => {
			homepage => 'https://github.com/0xxon/alien-openssl',
			bugtracker => 'https://github.com/0xxon/alien-openssl/issues',
			repository  => 'git://github.com/0xxon/alien-openssl.git',
		},
	},	
);


$builder->create_build_script;
