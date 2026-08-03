use Test2::V0 -no_srand => 1;
use Test::Alien;
use Alien::OpenSSL;

# If the libs path of a share install is incorrect, but the system provides
# an OpenSSL install anyway, XS code probably links to the system OpenSSL
# instead of the Alien one. This may introduce hard-to-trace bugs.

# This test verifies that the location of the dir for OpenSSL config files
# as reported by OpenSSL itself will be inside the share dir, as expected
# for a share install.

skip_all 'Test only useful for share install'
  unless Alien::OpenSSL->install_type('share');

alien_ok 'Alien::OpenSSL';

xs_ok do { local $/; <DATA> }, with_subtest {
  my($module) = @_;

  my $openssl_dir = $module->openssl_dir;
  $openssl_dir =~ s/\AOPENSSLDIR: "|"\z//g;

  if ($openssl_dir !~ m{\A/}) {
    diag "openssl_dir unavailable: $openssl_dir";
    skip_all 'openssl_dir unavailable';
  }

  my $prefix_dir = Alien::OpenSSL->runtime_prop->{prefix};
  my $xs_uses_share_install = $openssl_dir =~ m{\A\Q$prefix_dir\E\b};
  ok $xs_uses_share_install;

  if (! $xs_uses_share_install) {
    diag "prefix_dir  = $prefix_dir";
    diag "openssl_dir = $openssl_dir";
  }
};

done_testing;

__DATA__
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <openssl/crypto.h>

MODULE = TA_MODULE PACKAGE = TA_MODULE

const char *
openssl_dir(klass)
  CODE:
#if OPENSSL_VERSION_NUMBER < 0x0090700fL /* earlier than 0.9.7 */
    RETVAL = "OpenSSL too old";
#elif OPENSSL_VERSION_NUMBER < 0x1010000fL /* earlier than 1.1.0 */
    RETVAL = SSLeay_version(SSLEAY_DIR);
#else
    RETVAL = OpenSSL_version(OPENSSL_DIR);
#endif
  OUTPUT:
    RETVAL
