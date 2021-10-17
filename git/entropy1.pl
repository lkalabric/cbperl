#!perl -w
use strict;

sub log2 {
	my $n = shift;
	return (log($n)/ log(2));
}

open F, $ARGV[0] or die "usage: perl entropy.pl filename\n";
my @lines = <F>;
close F;

my (%words, $total, @text);

foreach my $line (@lines) {
	chomp $line;
	my @words = split /[^a-zA-Z]+/, $line;
	foreach my $word (@words) {
		$words{$word}++;
		$total++;
		push @text, $word;
	}
}

my $entropy;
foreach my $word (@text) {
	my $prob = $words{$word} / $total;
	$entropy += log2($prob);
}
$entropy *= -1;
$entropy = $entropy/$total;
print "entropy: $entropy\n";
print "perplexity: ", 2**$entropy, "\n";

=head1 NAME

entropy.pl - Calculates the per-word entropy of a text

=head1 SYNOPSIS

	perl entropy.pl textfile

=head1 DESCRIPTION

This program calculates the per-word entropy of a text based on unigram
probabilities. The text is given in an ascii file specified on the command-line.
Punctuation is stripped, but capitalized words are treated as distinct.

=head1 AUTHOR

Michael Hammond, F<hammond@u.arizona.edu>

=cut
