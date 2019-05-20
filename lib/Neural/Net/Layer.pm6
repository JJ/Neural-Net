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
			$neuron.inputs((@!inputs[$index]));
			$neuron.calc;
			@!outputs[$index] = $neuron.output;
		}
	}
}

sub input-layer (Rat @inputs --> Layer) is export {
	my Neuron @neurons = @inputs.map: -> $input { input-neuron($input) }
	return InputLayer.new(function => Linear.new, inputs => @inputs, neurons => @neurons);
}

class HiddenLayer does Layer {}

sub hidden-layer (Rat @inputs, Function $function, Int $neuron-count, Layer $previous) is export {
	my Neuron @neurons;
	
	@neurons.push(Neuron.new(function => $function, inputs => @inputs)) for ^$neuron-count;
	
	my Layer $layer = HiddenLayer.new(function => $function, inputs => @inputs, neurons => @neurons);
	$layer.previous-layer($previous);
	
	return $layer;
}

class OutputLayer does Layer {
	multi method next-layer (Layer $next) {}
}

sub output-layer (Rat @inputs, Function $function, Int $neuron-count, Layer $previous) is export {
	my Neuron @neurons;
	
	@neurons.push(Neuron.new(function => $function, inputs => @inputs)) for ^$neuron-count;
	
	my Layer $layer = OutputLayer.new(function => $function, inputs => @inputs, neurons => @neurons);
	$layer.previous-layer($previous);
	
	return $layer;
}
