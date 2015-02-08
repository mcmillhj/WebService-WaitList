#!/usr/bin/env perl

use strict;
use warnings;

use feature qw(say);
use Webservice::WaitList;

my $app = Webservice::WaitList->new;
my $charlottesville = '38.034667,-78.481145';
foreach my $restaurant ( $app->restaurants_near_me($charlottesville) ) {
   say $restaurant;
}
