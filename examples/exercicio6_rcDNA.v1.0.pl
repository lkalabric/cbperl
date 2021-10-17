#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio6_rcDNA.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Determina o reverso complemento do DNA
# a) Uso da fun��o reverse
# b) Uso do operador substituir s//
# c) Uso do operador traduzir tr//
# d) Uso do operador binging
# Sintaxe: perl exercicio6_rcDNA.v1.0.pl

# Armazena uma sequencia de DNA
my $dna = "ATCTGTGACTTAAA";

# Imprime o DNA na tela
print "Esta � a sequencia de DNA\n";
print "$dna\n\n";

# Reverte a sequencia de DNA
my $revcom = reverse $dna;

# Substitui A->T, T->A, C->G e G->C
$revcom =~ s/A/T/g; 
$revcom =~ s/T/A/g; 
$revcom =~ s/C/G/g; 
$revcom =~ s/G/C/g;

# Imprime o resultado
print "Eis o reverso complemento:\n";
print "$revcom\n\n";

# N�o funcionou! Sabe dizer por qu�?
print "Este foi um p�ssimo algoritmo e o reverso complemento est� errado!\n\n";

# Fa�amos uma nova c�pia do DNA e vamos usar o operador traduzir tr/
$revcom = reverse $dna;
$revcom =~ tr/ATCGatcg/TAGCtagc/;

# Imprime o resultado
print "Eis o reverso complemento correto:\n";
print "$revcom\n\n";

# Finaliza o programa
exit;