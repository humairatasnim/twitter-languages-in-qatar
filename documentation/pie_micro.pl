#!/usr/bin/perl
use strict;

use Chart::Clicker;
use Chart::Clicker::Context;
use Chart::Clicker::Data::DataSet;
use Chart::Clicker::Data::Marker;
use Chart::Clicker::Data::Series;
use Chart::Clicker::Renderer::Pie;
use Geometry::Primitive::Rectangle;
use Graphics::Color::RGB;

# build the color allocator
my $ca = Chart::Clicker::Drawing::ColorAllocator->new;

my ($series1, $series2, $series3, $series4);



# this hash is simply here to make things readable and cleaner, you can always call G::C::R inline
my $color1 = Graphics::Color::RGB->new({
    red => .55, green => .80, blue => .76, alpha => 1.0
});
my $color2 = Graphics::Color::RGB->new({
    red => .81, green => .93, blue=> .50, alpha=> 1.0
});
my $color3 = Graphics::Color::RGB->new({
    red => 1, green => .90, blue => .62, alpha => 1.0
});
my $color4 = Graphics::Color::RGB->new({
    red => 1, green => .62, blue => .56, alpha => 1.0
});

my $white = Graphics::Color::RGB->new({
    red => 1, green => 1, blue => 1, alpha => 0
});

my @colors = ($color1, $color2, $color3, $color4);
for (my $i=1; $i <= 4; $i++)
  {
    $ca->add_to_colors($colors[$i-1]);
  }

my $en = shift;
my $ar = shift;
my $tg = shift;
my $other = shift;


my $cc = Chart::Clicker->new(width => 32, height => 32, format => 'png');
$cc->legend->visible(0);


my @values = ($en, $ar, $tg, $other);
for (my $i=1; $i <= 4; $i++)
  {
    eval('$series'. $i . ' = Chart::Clicker::Data::Series->new(keys => [1],values => [' . $values[$i-1] . ']);');
  }

my $ds = Chart::Clicker::Data::DataSet->new(series => [ $series1, $series2, $series3, $series4 ]);


$cc->add_to_datasets($ds);


my $defctx = $cc->get_context('default');
my $pie = Chart::Clicker::Renderer::Pie->new;
$defctx->renderer($pie);
$defctx->domain_axis->hidden(1);
$defctx->range_axis->hidden(1);
$cc->plot->grid->visible(0);
$cc->border->width(0);
$cc->background_color($white);
# assign the color allocator to the chart
$cc->color_allocator($ca);
# EDIT: CHANGE OUTPUT NAME
my $filename = "./markers/${en}_${ar}_${tg}_${other}" .'.png';
$cc->write_output($filename);