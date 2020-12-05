use Test;
use Astro::Sunrise;
use Astro::Location;

plan 2 * 10 + 2; # 10 per location object

# check defaults
my $loc = Location.new;
is $loc.city, "Niceville", "city";
is $loc.state, "FL", "state";
is $loc.country, "USA", "country";
is $loc.timezone, "America/Chicago", "timezone";
is $loc.tz, -6, "tz";
is $loc.lat, 30.485092, "lat";
is $loc.lon, -86.4376157, "lon";
is $loc.isdst, 0, "isdst";
my $offset = $loc.lon < 0 ?? ceiling($loc.lon/15)
                          !! $loc.lon > 0 ?? floor($loc.lon /15)
                                          !! 0;
is $loc.offset, $offset, "offset";
is $loc.altit, $offset, "asltit";

# check another location
$loc = Location.new: :city<McIntyre>, :state<GA>,
:lat(32.8452393),
:lon(-83.1980807),
:timezone<America/New_York>, # EST
:tz(-5),
;
is $loc.city, "McIntyre", "city";
is $loc.state, "GA", "state";
is $loc.country, "USA", "country";
is $loc.timezone, "America/New_York", "timezone";
is $loc.tz, -5, "tz";
is $loc.lat, 32.8452393, "lat";
is $loc.lon, -83.1980807, "lon";
is $loc.isdst, 0, "isdst";
$offset = $loc.lon < 0 ?? ceiling($loc.lon/15)
                       !! $loc.lon > 0 ?? floor($loc.lon /15)
                                       !! 0;
is $loc.offset, $offset, "offset";
is $loc.altit, $offset, "asltit";

# Compare times with those given by the iIOS app Weather Bug
# at location Nicefile on 2020-12-05: 0631, 1647 
# I'll accept a result within five minutes of those times.
$loc = Location.new;
my ($year, $month, $day) = 2020, 12, 5;
my ($rise, $set) = sunrise $year, $month, $day,
                       $loc.lon, $loc.lat;
$rise = $rise.later :hour($loc.tz); # later because tz is negative
$set  = $set.later :hour($loc.tz);  # ditto
my $wb-rise = DateTime.new: :2020year, :12month, :5day, :6hour, :31minute;
my $wb-set  = DateTime.new: :2020year, :12month, :5day, :16hour, :47minute;
my $diff-rise = abs ($rise.posix - $wb-rise.posix).Num;
my $diff-set  = abs ($set.posix - $wb-set.posix).Num;
cmp-ok $diff-rise, '<', 300, "sunrise diff < 5 minutes";
cmp-ok $diff-set, '<', 300, "sunset diff < 5 minutes";
