[![Actions Status](https://github.com/tbrowder/Astro-Sunrise/workflows/test/badge.svg)](https://github.com/tbrowder/Astro-Sunrise/actions)

NAME
====

Astro::Sunrise - Calculate sunrise/sunset for a date and location

SYNOPSIS
========

```raku
$ cat ./examples/example.raku
#!/usr/bin/env raku

use lib <./lib ../lib>;
use Astro::Sunrise;
use Astro::Location;

# use a location in './t/tests.dat':
#    Amsterdam, Netherlands 52 22 N 4 53 E sunrise: 03:16 sunset: 20:09
my $loc = Location.new: :city<Amsterdam>, :state(''),
                        :country<NL>,
                        :lat(52+22/60),
                        :lon(4+53/60),
                        :timezone<Europe/Amsterdam>, # from Wikipedia
                        :tz(+1),                     # from Wikipedia
                        ;

# use the date from the test file '/t/01basic.t'
my $year  = 2003;
my $month = 6;
my $day   = 21;

# Note positional args, be careful!  A list of two DateTime objects
# are returned.  The tz value should NOT be applied as an input when
# testing for sunrise/sunset times using the original test data.
my ($rise, $set) = sunrise $year, $month, $day,
                       $loc.lon, $loc.lat;
# Output times as
my $sunrise = sprintf '%02d%02dZ', $rise.hour, $rise.minute;
my $sunset  = sprintf '%02d%02dZ', $set.hour, $set.minute;
say $sunrise; # expected: 0316Z
say $sunset;  # expected: 2009Z
```

Executing the code yields:

    0316Z
    2009Z

as expected.

AUTHOR
======

The original author was the late Jonathon Scott Duff (aka @perlpilot) who first published the module on January 6, 2016.

The module was forked from the original repository at <https://github.com/perlpilot/p6-Astro-Sunrise> to the Raku community modules repository <https://github.com/raku-community-modules/Astro-Sunrise> by @lizmat on November 26, 2020.

Some changes were made by Tom Browder (aka @tbrowder, <tbrowder@cpan.org>) who is currently reponsible for any bugs or modifications.

COPYRIGHT AND LICENSE
=====================

    &#x00A9; 2020 Raku.org

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

