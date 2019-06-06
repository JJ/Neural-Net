use v6.d;

use Neural::Net::Function;
use Neural::Net::Neuron;

unit module Neural::Net::Layer:ver<1.0.0>:auth<cpan:tmtvl>;

role Layer is export {
	has Neuron @.neurons;
	
	has Function $.function;
	
	has Layer $!previous-layer;
	has Layer $!next-layer;
	
	has Rat @.inputs;
	has Rat @!outputs;
	
	multi method previous-layer (Layer $previous) {
		$!previous-layer = $previous;
		$previous.next-layer(self) unless $previous.next-layer === self;
	}
	
	multi method previous-layer (--> Layer) {
		return $!previous-layer;
	}
	
	multi method next-layer (Layer $next) {
		$!next-layer = $next;
		$next.previous-layer(self) unless $next.previous-layer === self;
	}
	
	multi method next-layer (--> Layer) {
		return $!next-layer;
	}
	
	multi method inputs (Rat @inputs) {
		@!inputs = @inputs;
	}
	
	multi method inputs (--> Array[Rat]) {
		return @!inputs;
	}
	
	method outputs (--> Array[Rat]) {
		return @!outputs;
	}
	
	method init () {
		.function = $!function for @!neurons;
	}
	
	method calc () {
		for @!neurons.kv -> $index, $neuron {
			$neuron.inputs(@!inputs);
			$neuron.calc;
			@!outputs[$index] = $neuron.output;
		}
	}
}

class InputLayer does Layer {
	multi method previous-layer (Layer $previous) {}
	
	method calc () {
		for @!neurons.kv -> $index, $neuron {
			my Rat @in = (@!inputs[$index]);
			$neuron.inputs(@in);
			$neuron.calc;
			@!outputs[$index] = $neuron.output;
		}
	}
}

sub input-layer (Rat @inputs --> Layer) is export {
	my Neuron @neurons = @inputs.map: -> $input { input-neuron($input) }
	return InputLayer.new(function => Linear.new, inputs => @inputs,
		neurons => @neurons);
}

class HiddenLayer does Layer {}

sub hidden-layer (Rat @inputs, Function $function, Int $neuron-count,
				  Layer $previous --> Layer) is export {
	my Neuron @neurons;
	
	@neurons.push(Neuron.new(function => $function, inputs => @inputs)) for
		^$neuron-count;
	
	my Layer $layer = HiddenLayer.new(function => $function, inputs => @inputs,
		neurons => @neurons);
	$layer.previous-layer($previous);
	
	return $layer;
}

class OutputLayer does Layer {
	multi method next-layer (Layer $next) {}
}

sub output-layer (Rat @inputs, Function $function, Int $neuron-count,
				  Layer $previous --> Layer) is export {
	my Neuron @neurons;
	
	@neurons.push(Neuron.new(function => $function, inputs => @inputs)) for
		^$neuron-count;
	
	my Layer $layer = OutputLayer.new(function => $function, inputs => @inputs,
		neurons => @neurons);
	$layer.previous-layer($previous);
	
	return $layer;
}

=begin pod

=head1 NAME

Neural::Net::Layer

=head1 SYNOPSIS

	=begin code
	use Neural::Net::Layer;
	
	my Layer $input-layer = input-layer(@inputs);
	my Layer $hidden-layer = hidden-layer(@inputs, $function, $neuron-count,
		$previous-layer);
	my Layer $output-layer = output-layer(@inputs, $function, $neuron-count,
		$previous-layer);
	=end code

=head1 DESCRIPTION

Neural::Net::Layer is the abstraction of processing via neurons.
There are 3 types of layer:

=defn Input Layers
Which receive stimuli from the outside world.

=defn Output Layers
Which fire actions that affect the outside world.

=defn Hidden Layers
Which are invisible (hidden) from the outside world.

In artificial neural networks a layer has the same inputs and activation
functions for all of its composing neurons.
Layers are linked since one layer forwards its values to the next.

=head1 OPTIONS

There are 3 factory methods for layers, one for input layers, one for hidden
layers, and one for output layers.

=begin item
Input layers have no preceding layers and have only a simple linear function
without bias.

	=begin code
	my Layer $input-layer = input-layer(@inputs);
	=end code
=end item

=begin item
Hidden layers do most of the heavy lifting and link in two directions.

	=begin code
	my Layer $hidden-layer = hidden-layer(@inputs, $function, $neuron-count,
		$previous-layer);
	=end code
=end item

=begin item
Output layers have no succeeding layers and trigger the final functions.

	=begin code
	my Layer $output-layer = output-layer(@inputs, $function, $neuron-count,
		$previous-layer);
	=end code
=end item

=head1 SUPPORT

Please report bugs or file feature requests via github:
L<https://github.com/tmtvl/Neural-Net/issues>

=head1 AUTHOR

Tim Van den Langenbergh L<tmt_vdl@gmx.com>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl6 itself.

=end pod
