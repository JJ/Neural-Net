use v6.d;

use Neural::Net::Function;
use Neural::Net::Neuron;

unit module Neural::Net::Layer:ver<0.0.1>:auth<cpan:tmtvl>;

role Layer is export {
	has Neuron @.neurons;
	
	has Function $.function;
	
	has Layer $!previous-layer;
	has Layer $!next-layer;
	
	has Rat @.inputs;
	has Rat @!outputs;
	
	multi method previous-layer (Layer $previous) {
		$!previous-layer = $previous;
		$previous.next-layer(self) unless $previous.next-layer == self;
	}
	
	multi method previous-layer (--> Layer) {
		return $!previous-layer;
	}
	
	multi method next-layer (Layer $next) {
		$!next-layer = $next;
		$next.previous-layer(self) unless $next.previous-layer == self;
	}
	
	multi method next-layer (--> Layer) {
		return $!next-layer;
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
	submethod TWEAK () {
		self.init;
	}
}

sub input-layer (Rat @inputs --> Layer) is export {
	my Neuron @neurons = @inputs.map: -> $input { input-neuron($input) }
	return InputLayer.new(function => Linear.new, inputs => @inputs, neurons => @neurons);
}
