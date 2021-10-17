#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio3_inputArgumentos.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Entra dados atrav�s de argumentos da linha de comando e imprimir seus valores
# a) Uso variavel especial @ARGV
# Sintaxe: perl exercicio3_inputArgumentos.v1.0.pl <arg1> <arg2>

# Imprime os argumentos da linha de comando
print "Este foi o primeiro argumento passado: $ARGV[0]\n"; 		# imprime o primeiro argumento 
print "Este foi o segundo argumento passado: $ARGV[1]\n"; 		# imprime o segundo argumento

# Este programa n�o � muito interessante, pois imprime o resultado sem realizar qualquer opera��o!

# Finaliza o programa
exit;