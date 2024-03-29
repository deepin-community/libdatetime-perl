BEGIN {
    $ENV{PERL_DATETIME_PP} = 1;
}

## no critic (Modules::ProhibitMultiplePackages)
use strict;
use warnings;

use Test::More;
use DateTime;

undef $ENV{PERL_DATETIME_DEFAULT_TZ};

{
    package DateTime::MySubclass;
    use parent 'DateTime';

    sub duration_class {'DateTime::Duration::MySubclass'}

    package DateTime::Duration::MySubclass;
    use parent 'DateTime::Duration';

    sub is_my_subclass {1}
}

my $dt    = DateTime::MySubclass->now;
my $delta = $dt - $dt;

isa_ok( $delta,       'DateTime::Duration::MySubclass' );
isa_ok( $dt + $delta, 'DateTime::MySubclass' );

my $delta_days = $dt->delta_days($dt);
isa_ok( $delta_days, 'DateTime::Duration::MySubclass' );

done_testing();

