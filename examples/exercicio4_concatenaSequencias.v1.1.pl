#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio4_concatenaSequencias.v1.1.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Concatena sequencias de DNA e imprime o valor
# a) Uso o operador concatenar .
# b) Uso da fun��o scalar
# c) Uso do operador l�gico or
# d) Uso do controle de fluxo die 
# Sintaxe: perl exercicio4_concatenaSequencias.v1.1.pl <seq1> <seq2>

# Valida se os dois par�metros foram passados ao program sen�o "die" ou sai do programa
scalar ( @ARGV ) == 2 or die "\nN�mero de argumento deve ser 2.\n\n\$ perl exercicio4_concatenaSequencias.v1.1.pl seq1 seq2\n\n";

# Armazena as duas sequencias de DNA em $dna1 e $dna2
my ($dna1, $dna2) = @ARGV; # Entrada atrav�s do cursor do teclado

# Imprime os valores das sequencias
print "Esta foi a primeira sequencia $dna1\n";
print "Esta foi a segunda sequencia $dna2\n\n";

# Concatena os valores em $dna3
my  $dna3 = $dna1 . $dna2;	# Equivalente a my $dna3 = "$dna1$dna2";

# Imprime a sequencia concatenada
print "Aqui est� a sequencia concatenada $dna3\n";

# Finaliza o programa
exit;