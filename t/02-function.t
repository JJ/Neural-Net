#!/usr/bin/env perl6
use v6.d;

use Test;
use Neural::Net::Function;

plan 4;

my Function $hypertan = HyperTan.new;
my Function $linear = Linear.new;
my Function $sigmoid = Sigmoid.new;
my Function $step = Step.new;

my Rat $hypertan-result = 0.4621171573;
my Rat $sigmoid-result = 0.731058579;

is-approx $hypertan.calc(1.0), $hypertan-result, "hypertangent of 1.0 and 1.0";
is-approx $linear.calc(1.0), 1.0, "linear multiplication of 1.0 and 1.0";
is-approx $sigmoid.calc(1.0), $sigmoid-result, "sigmoid of 1.0 and 1.0";
is-approx $step.calc(1.0), 1.0, "step of 1.0";

done-testing;
