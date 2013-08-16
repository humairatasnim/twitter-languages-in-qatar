#!/usr/bin/perl
use strict;

my $input = shift;
my $output = shift;
open(INPUT,$input) or die $!;
open(OUTPUT,">$output") or die $!;



while(<INPUT>)
  {
    chomp;
    my $line = $_;
    my @values = split(/\t/);
    my ($en, $ar, $tg) = (int($values[2]+.5), int($values[3]+.5), int($values[4]+.5));
    my $other = 0;

    for (my $i=5; $i<13; $i++)
      {
	$other += int($values[$i] + .5);
      }

    @values = ($en, $ar, $tg, $other);

    `mkdir markers 2> /dev/null`;
    `./pie_micro.pl $en $ar $tg $other`;
    my $filename = "${en}_${ar}_${tg}_${other}" .'.png';
    print OUTPUT "$line\t$filename\n";
  }
close INPUT;
