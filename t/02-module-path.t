#!perl

use strict;
use warnings;

use Test::More 0.88 tests => 3;

use Module::Path 'module_path';

# This test does "use strict", so %INC should include the path where
# strict.pm was found, and module_path should find the same
ok(module_path('strict') eq $INC{'strict.pm'},
   "check 'strict' matches \%INC") || do {
    warn "\n",
         "    \%INC        : $INC{'strict.pm'}\n",
         "    module_path : ", (module_path('strict') || 'undef'), "\n",
         "    \$^O         : $^O\n";
};

ok(module_path('Test/More.pm') eq $INC{'Test/More.pm'},
   "confirm that module_path() works with partial path used as key in \%INC") || do {
    warn "\n",
         "    \%INC        : $INC{'Test/More.pm'}\n",
         "    module_path : ", (module_path('Test/More.pm') || 'undef'), "\n",
         "    \$^O         : $^O\n";
};

# module_path() returns undef if module not found in @INC
ok(!defined(module_path('No::Such::Module')),
   "non-existent module should result in undef");
