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
