use v6.d;

use Neural::Net::Function;

unit module Neural::Net::Neuron:ver<1.0.1>:auth<cpan:tmtvl>;

class Neuron is export {
	has Function $.function is rw is required;
	
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
			$oba = ($oba + $input * @!weights[$index]).Rat;
		}
		
		$oba += $!bias * @!weights[* - 1] if @!inputs;
		
		$!output-before-activation = $oba;
		$!output = $!function.calc($oba);
	}
}

sub input-neuron (Rat $input? --> Neuron) is export {
	my Neuron $neuron .= new(function => Linear.new, bias => 0.0);
	
	if ($input) {
		my Rat @in = ($input);
		$neuron.inputs(@in);
	}
	
	return $neuron;
}

=begin pod

=head1 NAME

Neural::Net::Neuron

=head1 SYNOPSIS

	=begin code
	use Neural::Net::Neuron;
	
	my Rat @inputs = (1.0, 1.5);
	my Neuron $input-neuron = input-neuron(@inputs);
	
	use Neural::Net::Function;
	
	my Neuron $neuron .= new(function => Sigmoid.new, inputs => @inputs);
	=end code

=head1 DESCRIPTION

Neural::Net::Neuron is the basic building block of a neural network.
Neural networks are compromised of a number of layers which each contain one or 
more neurons which trigger the adjustments of the inputs based on the bias and 
the selected mathematical function.

=head1 OPTIONS

One can either initialise a neuron manually (note: function is required):

	=begin code
	my Neuron @neuron .= new(function => $function);
	=end code

Or use the input-neuron function to create a neuron with a bias of 0 and a 
standard Linear function:

	=begin code
	my Neuron $input-neuron = input-neuron;
	=end code

=head1 SUPPORT

Please report bugs or file feature requests via github: L<https://github.com/tmtvl/Neural-Net/issues>

=head1 AUTHOR

Tim Van den Langenbergh L<tmt_vdl@gmx.com>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=end pod
