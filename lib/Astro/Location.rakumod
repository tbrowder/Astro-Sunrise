unit class Astro::Location is export;

# defaults for Niceville, FL, USA
has $.city     = "Niceville";
has $.state    = "FL";
has $.country  = "USA";
has $.lat      = 30.485092;
has $.lon      = -86.4376157;
has $.timezone = "America/Chicago"; # the name (CST)
has $.tz       = -6; #    the number (isdst=False)
has $.isdst    = 0;
has $.offset   = 0; # a correction calculated based on longitude
has $.altit    = 0; # alias for offset used by @perlpilot
submethod TWEAK {
    if $!lon < 0  {
        $!altit = ceiling( $!lon / 15 );
    }
    elsif $!lon > 0 {
        $!altit = floor( $!lon / 15 );
    }
    $!offset = $!altit;
}
