#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo_randomMutation.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-08-12
# Uso: Gera muta��es em sitios aleat�rios de uma sequencia DNA
# a) Fun��o int
# b) Fun��o rand

# Declara e inicializa as variaveis globais
my $dna = "ATGTTGTTGTCTCAAGTCATATGTA";

# Seleciona uma posi��o aleat�ria
my $posicao = randomposition ($dna);

# Seleciona um nucleotideo aleat�rio
my $new_base= randomnucleotide ();

# Faz a muta��o
my $mutant = $dna;
substr($mutant,$posicao,1,$new_base); # Altera 1 caractere da variavel $mutant na $posicao pelo $new_base

# Imprime os resultados
print "DNA selvagem: $dna\n";
print "DNA mutante : $mutant\n";

# Finaliza o programa
exit;

sub randomposition {
	my ($input) = @_;
	return int rand length $input;
}

sub randomnucleotide {
	my @nt = ("A", "T", "G", "C");
	return $nt [int rand scalar @nt];
}