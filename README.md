[![Build Status](https://travis-ci.org/tmtvl/Zodiac-Chinese.svg?branch=master)](https://travis-ci.org/tmtvl/Zodiac-Chinese)
# Neural::Net

Neural Network in Perl 6.

## Synopsis

```perl6
use Neural::Net;
use Neural::Net::Function;

my Function $sigmoid = Sigmoid.new;

my Rat @inputs = (0.5, 1.5);
my Int $output-neurons = 1;

my Function @hidden-functions;
my Rat @hidden-neurons;

my NeuralNet $neural-net = neural-net(@inpucts, $output-neurons, @hidden-neurons,
	@hidden-functions, $output-neuron)

$neural-net.calc;

my Rat @outputs = $neural-net.outputs;
```

## Description

The Neural::Net module provides a basic implementation of a neural network that
people who are interested in ML can play around with. It is not meant for
serious work, more as a proof of concept, and a starting point from where more
advanced projects can begin.

## Author

Tim Van den Langenbergh ([tmt_vdl@gmx.com](mailto:tmt_vdl@gmx.com))

Source code located at: [github](https://github.com/tmtvl/Neural-Net). Comments
and pull requests are welcome.

## Copyright and license

This library is free software; you can redistribute it and/or modify it under
the Artistic License 2.0.
