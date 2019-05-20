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
		Function @hidden-functions, Function $output-function --> NeuralNet) is export {
	my Layer @hidden-layers;
	my Layer $output-layer;
	
	my Layer $input-layer = input-layer(@inputs);
	
	if (@hidden-functions.elems) {
		@hidden-layers[0] = hidden-layer(@inputs, @hidden-functions[0], @hidden-neurons[0], $input-layer);
		
		for 1..^@hidden-functions.elems -> $index {
			@hidden-layers[$index] = hidden-layer(@inputs, @hidden-functions[$index], @hidden-neurons[$index], @hidden-layers[$index - 1]);
		}
	}
	else {
		$output-layer = output-layer(@inputs, $output-function, $output-neurons, $input-layer);
	}
	
	return NeuralNet.new(input-layer => $input-layer, output-layer => $output-layer, inputs => @inputs, hidden-layers => @hidden-layers);
}
