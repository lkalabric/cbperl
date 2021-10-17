#!/usr/bin/perl
# Entropy H({x_1,...,x_n}) of random variable X={x_1,...,x_n}
# H(X) := -\sum_{i=1}^{n} p(x_i) log_b p(x_i)
#  H(x) ~ Thermodynamic entropy with k_b = 1

# extract distribution of random variable X
while (<STDIN>)
{
 $nx{$_}++ foreach (split //);
}
$n += $_ foreach (values %nx);
# calculate entropy
foreach my $x (keys %nx)
{
 my $px = $nx{$x} / $n;
 $H -= $px * log($px);
}
$H /= log(2);
printf "Entropy %.2f bits (total bytes %d)\n", $H, $n;﻿