#!/usr/bin/env perl6
use v6.d;

use Test;
use Neural::Net;

plan 1;

lives-ok { NeuralNet.new }, "neural net";

done-testing;
