#!/usr/bin/env perl6
use v6.d;

use Test;
use Neural::Net::Function;
use Neural::Net::Layer;

plan 3;

my Rat @inputs = <0.5 1.5>;
my Function $step = Step.new;
my Int $neuron-count = 1;

lives-ok { input-layer(@inputs) }, "input layer";
lives-ok { hidden-layer(@inputs, $step, $neuron-count, input-layer(@inputs)) }, "hidden layer";
lives-ok { output-layer(@inputs, $step, $neuron-count, input-layer(@inputs)) }, "output layer";

done-testing;
