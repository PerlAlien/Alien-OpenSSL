use strict;
use warnings;
use IPC::Cmd qw/can_run/;

use Alien::Base::ModuleBuild;

my $addcc = "";
$addcc = "CC=cc " if ( (!can_run('gcc')) && can_run('cc') );

my $builder = Alien::Base::ModuleBuild->new (
	(sign => 1),
	module_name => 'Alien::OpenSSL',
	license => 'perl',
	configure_requires => {
		'Alien::Base' => '0.002', # pre-003 versions have a few severe bugs
		'Module::Build' => '0.38',
		'Test::More' => 0,
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
		$addcc.'%pconfig shared --prefix=%s',
		$addcc.'make',
		$addcc.'make test',
		],
	alien_install_commands => [
	        'make install_sw',
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
