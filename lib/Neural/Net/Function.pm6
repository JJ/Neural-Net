use v6.d;

unit module Neural::Net::Function:ver<1.0.1>:auth<cpan:tmtvl>;

role Function is export {
	has Rat $.a is rw = 1.0;
	
	method calc (Rat $x --> Rat) { ... }
}

class HyperTan does Function is export {
	method calc (Rat $x --> Rat) {
		return ((1 - e ** (-$!a * $x)) / (1 + e ** (-$!a * $x))).Rat(1e-16);
	}
}

class Linear does Function is export {
	method calc (Rat $x --> Rat) {
		return $!a * $x;
	}
}

class Sigmoid does Function is export {
	method calc (Rat $x --> Rat) {
		return (1 / (1 + e ** (-$!a * $x))).Rat(1e-16);
	}
}

class Step does Function is export {
	method calc (Rat $x --> Rat) {
		return $x < 0.0 ?? 0.0 !! 1.0;
	}
}

=begin pod

=head1 NAME

Neural::Net::Function

=head1 SYNOPSIS

	=begin code
	use Neural::Net::Function;
	
	my Function $hypertan = HyperTan.new;
	my Function $linear = Linear.new;
	my Function $sigmoid = Sigmoid.new;
	my Function $step = Step.new;
	
	my Rat $out-hypertan = $hypertan.calc(1.0);
	my Rat $out-linear = $linear.calc(1.0);
	my Rat $out-sigmoid = $sigmoid.calc(1.0);
	my Rat $out-step = $step.calc(1.0);
	=end code

=head1 DESCRIPTION

Neural::Net::Function contains the basic functions that are used to transform
neural inputs into neural outputs. With the notable exception of the linear
function these are nonlinear and bounded between two values at the output.

Functions are detailed in LaTeX formatting below.

=head2 HYPERTAN

Alias: hyperbolic tangent.
Function: f(x) &= \frac{1-e^{-ax}}{1+e^{-ax}}

=head2 LINEAR

Function: f(x) = ax

=head2 SIGMOID

Function: f(x) &= \frac{1}{1+e^{-ax}}

=head2 STEP

Alias: hard limiting threshold.
Function: f(x) = \binom{0 if x < 0}{1 if x \geq 0}

=head1 OPTIONS

Defining I<a> is optional, by default it is set to 1.0.

	=begin code
	my Function $f = Linear.new(a => 0.5);
	=end code
	
Note that I<a> is not used for the step function.

=head1 SUPPORT

Please report bugs or file feature requests via github: L<https://github.com/tmtvl/Neural-Net/issues>

=head1 AUTHOR

Tim Van den Langenbergh L<tmt_vdl@gmx.com>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=end pod
