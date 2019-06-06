use v6.d;

use Neural::Net::Function;
use Neural::Net::Layer;

unit module Neural::Net:ver<0.0.1>:auth<cpan:tmtvl>;

class NeuralNet is export {
	has Layer $.input-layer;
	has Layer $.output-layer;
	
	has Layer @.hidden-layers;
	
	has Rat @.inputs;
	has Rat @!outputs;
	
	method outputs (--> Array[Rat]) {
		return @!outputs;
	}
	
	method calc () {
		$!input-layer.inputs(@!inputs);
		
		$!input-layer.calc;
		
		for @!hidden-layers -> $hidden-layer {
			$hidden-layer.inputs($hidden-layer.previous-layer.outputs);
			$hidden-layer.calc;
		}
		
		$!output-layer.inputs($!output-layer.previous-layer.outputs);
		
		$!output-layer.calc;
		
		@!outputs = $!output-layer.outputs;
	}
}

sub neural-net (Rat @inputs, Int $output-neurons, Int @hidden-neurons,
		Function @hidden-functions, Function $output-function --> NeuralNet)
		is export {
	my Layer @hidden-layers;
	my Layer $output-layer;
	
	my Layer $input-layer = input-layer(@inputs);
	
	if (@hidden-functions.elems) {
		@hidden-layers[0] = hidden-layer(@inputs, @hidden-functions[0],
			@hidden-neurons[0], $input-layer);
		
		for 1..^@hidden-functions.elems -> $index {
			@hidden-layers[$index] = hidden-layer(@inputs,
				@hidden-functions[$index], @hidden-neurons[$index],
				@hidden-layers[$index - 1]);
		}
		
		$output-layer = output-layer(@inputs, $output-function, $output-neurons,
			@hidden-layers[* - 1]);
	}
	else {
		$output-layer = output-layer(@inputs, $output-function, $output-neurons,
			$input-layer);
	}
	
	return NeuralNet.new(input-layer => $input-layer,
		output-layer => $output-layer, inputs => @inputs,
		hidden-layers => @hidden-layers);
}

=begin pod

=head1 NAME

Neural::Net

=head1 SYNOPSIS

	=begin code
	use Neural::Net;
	
	my NeuralNet $neural-net .= new(input-layer => $input-layer,
		output-layer => $output-layer, inputs => @inputs,
		hidden-layers => @hidden-layers);
	
	my NeuralNet $nn = neural-net(@inpucts, $output-neurons, @hidden-neurons,
		@hidden-functions, $output-neuron);
	=end code

=head1 DESCRIPTION

Neural::Net is a basic neural network.
It has a number of neurons which are organized into layers, and has at least two
layers: the input layer and output layer; with an optional number of hidden
layers.

=head1 OPTIONS

One can either initialise a network manually, allowing for fine tuning of the
layers:

	=begin code
	my NeuralNet $neural-net .= new(input-layer => $input-layer,
		output-layer => $output-layer, inputs => @inputs,
		hidden-layers => @hidden-layers);
	=end code

Or use the factory method to quickly create one with the provided parameters:

	=begin code
	my NeuralNet $nn = neural-net(@inpucts, $output-neurons, @hidden-neurons,
		@hidden-functions, $output-neuron);
	=end code

=head1 SUPPORT

Please report bugs or file feature requests via github:
L<https://github.com/tmtvl/Neural-Net/issues>

=head1 AUTHOR

Tim Van den Langenbergh L<tmt_vdl@gmx.com>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=end pod
