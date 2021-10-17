#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio2_entradaTeclado.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Entra a sequencia de DNA a partir do teclado, armazena numa variavel escalar e imprime seu valor
# a) Uso operador <filehandle>
# b) Uso da função chomp
# Sintaxe: perl exercicio2_entradaTeclado.v1.0.pl

# Informa ao usuário que dado pretende obter pelo teclado
print "Entre uma sequencia de DNA: ";

# Entra dados através do teclado
my $dna = <STDIN>;

chomp $dna; # Remove a quebra de linha

# Imprime o valor da variável $dna
print "\nA sequencia de DNA digitada foi: $dna\n";

# Finaliza o programa
exit;
