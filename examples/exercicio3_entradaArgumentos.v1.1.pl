#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio3_entradaArgumentos.v1.1.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Entra dados atrav�s de argumentos da linha de comando e imprimir seus valores
# a) Uso variavel especial @ARGV
# b) Uso do condicional or die
# Sintaxe: perl exercicio3_entradaArgumentos.v1.1.pl <arg1> <arg2>

# Uso de "or die"
scalar ( @ARGV ) == 2 or die "\nN�mero de argumento deve ser 2.\n\n\$ perl exercicio3_entradaArgumentos.v1.1.pl <arg1> <arg2>\n\n";

# Este programa n�o � muito inteligente, pois imprime o resultado diretamente sem realizar qualquer opera��o!
print "Este foi o primeiro argumento passado: $ARGV[0]\n"; 		# imprime o primeiro argumento DNA
print "Este foi o segundo argumento passado: $ARGV[1]\n"; 		# imprime o segundo argumento ATCGTCTGT

# Finalmente, vamos finalizar o programa
exit;