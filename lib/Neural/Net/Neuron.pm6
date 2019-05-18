use v6.d;

use Neural::Net::Function;

unit module Neural::Net::Neuron:ver<0.0.1>:auth<cpan:tmtvl>;

class Neuron is export {
	has Function $.function is required;
	
	has Rat $.bias is rw = 1.0;
	
	has Rat @!weights;
	
	has Rat @.inputs is rw;
	
	has Rat $!output;
	has Rat $!output-before-activation;
	
	submethod TWEAK () {
		self.generate-weights;
	}
	
	multi method inputs (Rat @inputs, Bool :$force = False) {
		@!inputs = @inputs;
		
		self.generate-weights if @!inputs.elems >= @!weights.elems || :$force;
	}
	
	multi method inputs (--> Array[Rat]) {
		return @!inputs;
	}
	
	method output (--> Rat) {
		return $!output;
	}
	
	method output-before-activation (--> Rat) {
		return $!output-before-activation;
	}
	
	method generate-weights () {
		for 0..@!inputs.elems -> $i {
			@!weights[$i] = rand.Rat;
		}
	}
	
	method calc () {
		self.generate-weights if not @!weights;
		my Rat $oba = 0.0;
		
		# TODO: Optimize.
		for @!inputs.kv -> $index, $input {
			$oba += $input * @!weights[$index];
		}
		
		$oba += $!bias * @!weights[* - 1] if @!inputs;
		
		$!output-before-activation = $oba;
		$!output = $!function.calc($oba);
	}
}
