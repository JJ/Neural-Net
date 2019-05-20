#!/usr/bin/env perl6
use v6.d;

use Test;
use Neural::Net;
use Neural::Net::Function;

plan 2;

my Rat @inputs;
my Int @hidden-neurons;
my Function @hidden-functions;

lives-ok { NeuralNet.new }, "neural net";
lives-ok { neural-net(@inputs, 0, @hidden-neurons, @hidden-functions, Linear.new) }, "builder method";

done-testing;
