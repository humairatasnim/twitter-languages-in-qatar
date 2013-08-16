#!/usr/local/bin/perl -w

use strict;
my $parameter = 50;

open (MYFILE, 'geo_tweets_from_qatar_with_language_with_tweetid.txt');
while(<MYFILE>)
{
  chomp;
  my ($userid, $tweetid, $tweettext, $lat, $long, $lang) = split(/\t/);
  next unless (($tweetid =~ /^[0-9]+$/) && ($lang =~ /^\w+$/) && ($lat =~ /^-?[0-9\.]+$/) && ($long =~ /^-?[0-9\.]+$/)
  	&&  ($lat >= 24.47112) && ($lat <= 26.18471) && ($long >= 50.73349) && ($long <= 51.64355));
  $lat = round($lat);
  $long = round($long);
  print STDOUT join("\t",($userid,$tweetid,$tweettext,$lat,$long,$lang)) . "\n";
}
 
sub round
{
  return int($_[0]*$parameter + 0.5)/$parameter;
}

# 1. Use the tweet id, lat, long, language columns.

# 2. Remove coordinates (latitude, longitude) that are out of Qatar.

# Qatar's boundary coordinates:
# top:    26.18471, 51.237144
# left:   25.65762, 50.73349
# right:  25.296854, 51.645355
# bottom: 24.47112, 51.098616

# - open file geo_tweets.txt
# - read each line and run through conditional statement:
# if (24.47112 <= latitude <= 26.18471= && 50.73349 <= longitude <= 51.64355)

# 3. Round resulting coordinates (latitude, longitude) to centroids.
# if (24.47112 <= Latitude < 26.18471= AND 50.73349 <= Longitude <= 51.64355)
# { run through the round.pl script }

# output file: user id, tweet id, tweet text, latitude, longitude, language
# with common centroids (latitudes, longitudes)