#!/usr/bin/env perl6
use v6.d;

use Test;
use Neural::Net::Function;
use Neural::Net::Neuron;

plan 3;

my Neuron $neuron .= new(function => Step.new);

$neuron.calc;

is-approx $neuron.output, 1.0, "neural output";
is-approx $neuron.output-before-activation, 0.0, "output before activation";

lives-ok { input-neuron }, "input neuron";

done-testing;
