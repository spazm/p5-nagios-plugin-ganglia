use strict;
use warnings;

package Nagios::Plugin::Ganglia;

use Nagios::Plugin;
my $VERSION = "0.0.1";
my $np      = Nagios::Plugin->new(
    shortname => 'GMETAD',
    usage => "Usage: %s [ -v|--verbose ] [-H <host>] [-p <port>] [-t timeout>]"
      . "[ -c|--critical=<threshold> ] [ -w|--warning=<threshold> ]",
    version => $VERSION,
    blurb   => "Query gmetad values from nagios",
);

$np->add_arg(
    spec    => 'port|p=i',
    help    => '-p, --port=INTEGER:INTEGER nagios port (default %s)',
    default => 8649,
);

$np->getopts;
my $hostname = $np->opts->host;

#get_gmond( $np->opts->host, $np->opts->port );

my $value;
my $code = $np->check_threshold(
    check    => $value,
    warning  => $np->opts->warning_threshold,
    critical => $np->opts->critical_threshold,
);

$np->nagios_exit( $code, "Threshold check failed" ) if $code != OK;

1;
