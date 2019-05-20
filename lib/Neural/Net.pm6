use v6.d;

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
