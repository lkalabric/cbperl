#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio8_contaATCG.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Conta nucleotideos de uma sequencia de DNA e calcula %AT e %CG
# a) Uso da função splip
# b) Usa o comando for para condicional e controle de loop
# c) Usa o comando if para condicional
# d) Usa operadores aritméticos +, -, /, ++
# Sintaxe: perl exercicio8_contaATCG.v1.0.pl

# Entrada de dados
my $dna = "TAGCAGTCGCTAGTCTA";

# Converte a string em um array
my @nucleotideo = split ("",$dna);

# Inicializa os contadores de A, T, C e G
my $num_A = 0;
my $num_T = 0;
my $num_C = 0;
my $num_G = 0;
my $err = 0;

my $num_nt = @nucleotideo; 		# Neste contexto tem o mesmo efeito da função scalar. Calcula o tamanho do array
print "O DNA $dna possui $num_nt nucleotideos\n\n";
 
# Conta cada nucleotídeo (vide as versões 2.0 e 3.0 para comparação)
for (my $i = 0; $i < $num_nt; $i++) {
	if ($nucleotideo[$i] eq "A") {
		$num_A++; 		# Soma + 1 no contador de As
	} elsif ($nucleotideo[$i] eq "T") {
		$num_T++; 		# Soma + 1 no contador de Ts
	} elsif ($nucleotideo[$i] eq "C") {
		$num_C++; 		# Soma + 1 no contador de Cs
	} elsif ($nucleotideo[$i] eq "G") {
		$num_G++; 		# Soma + 1 no contador de Gs
	} else {
		$err++;			# Soma + 1 no contador de Erros
	}
} 
print "A = $num_A, T = $num_T, G = $num_G, C = $num_C, Err = $err\n";

# Calcula o percentual de AT e GC
my $AT = ($num_A + $num_T) / $num_nt;
my $CG = ($num_C + $num_G) / $num_nt;
print "\%AT = $AT, \%CG = $CG\n";

# Finaliza o programa
exit;