use strict;
use warnings;

use Test::More tests => 8;

BEGIN { use_ok('Log::Syslog::Fast::Simple', ':all') };

my $logger = Log::Syslog::Fast::Simple->new(
    proto    => LOG_UDP,
    loghost  => 'localhost',
    port     => 514,
    facility => LOG_LOCAL1,
    severity => LOG_DEBUG,
    sender   => 'mymachine',
    name     => 'test',
);
ok($logger, "->new returns something");

$logger = Log::Syslog::Fast::Simple->new;
ok($logger, "->new with defaults returns somethings");

is(ref $logger, 'Log::Syslog::Fast::Simple', '->new returns a Log::Syslog::Fast::Simple object');

eval {
    $logger->send("testing");
};
ok(!$@, "->send with defaults doesn't throw");

eval {
    $logger->send("testing ", time, LOG_LOCAL3, LOG_INFO);
};
ok(!$@, "->send with overrides doesn't throw");

# just check one of each
is(LOG_DEBUG,    7,  'LOG_DEBUG');
is(LOG_LOCAL0,   16, 'LOG_LOCAL0');