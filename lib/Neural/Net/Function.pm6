use v6.d;

unit module Neural::Net::Function:ver<1.0.0>:auth<cpan:tmtvl>;

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
