#!/usr/bin/env perl6
use v6.d;

use Test;
use Neural::Net::Layer;

plan 1;

my Rat @inputs = <0.5 1.5>;

lives-ok { input-layer(@inputs) }, "input layer";

done-testing;
