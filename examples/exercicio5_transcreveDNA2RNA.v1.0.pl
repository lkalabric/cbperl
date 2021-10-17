#!/usr/bin/perl 
use strict;
use warnings;

# Programa: exercicio5_transcreveDNA2RNA.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Transcreve o DNA em RNA e imprime o resultado
# a) Uso do operador de substituicao;
# b) Uso do operador de vinculacao ou ligacao (binding operator);
# Sintaxe: perl exercicio5_transcreveDNA2RNA.v1.0.pl

# Entrada do dado direto no código-fonte
my $dna = 'ACGGGAGGACGGGAAAATTACTACGGCATTAGC'; # Neste contexto apostrofo é equivalente a aspas

# Exibe o DNA na tela
print "Esta é o DNA inicial:\n";
print "$dna\n\n";
	  
# Transcreve o DNA em RNA substituindo T's por U's.
my $rna = $dna;
$rna =~ s/T/U/g; 	# O operador binding =~ processa o operador substituição e armazena o resultado na variável $rna
					# O operador substituição s/ substitui o padrão “T” pelo padrão “U”. O modificador“g” indica que a substituição ocorrerá de forma global, ou seja, ao longo de toda a string

# Exibe o RNA na tela
print "Esse é o resultado da transcrição do DNA em RNA:\n";
print "$rna\n";

# Finaliza o programa
exit;

