#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio8_contaATCG.v3.0.pl
# Autor: Luciano Kalabric
# Data: 2014-05-02
# Uso: Conta nucleotideos de uma sequencia de DNA e calcula %AT e %CG
# a) Uso da função splip
# b) Usa o comando for para condicional e controle de loop
# c) Usa o comando if para condicional
# d) Usa operadores aritméticos +, -, /, ++
# Sintaxe: perl exercicio8_contaATCG.v1.0.pl
# Referencia:
# Tisdall, J. Beginning Perl for bioinformatics. Sebastopol: O’reilly, 2001

# Entrada de dados
my $dna = "TAGCAGTCGCTAGTCTA";

# Inicializa os contadores de A, T, C e G
my $num_A = 0;
my $num_T = 0;
my $num_C = 0;
my $num_G = 0;
my $err = 0;

# Conta cada nucleotídeo (vide as versões 1.0 e 2.0 para comparação)
$num_A = ($dna =~ tr/Aa//);
$num_T = ($dna =~ tr/Tt//);
$num_C = ($dna =~ tr/Cc//);
$num_G = ($dna =~ tr/Gc//);

# Calcula o total de nucleotideos
my $num_nt = $num_A + $num_T + $num_C + $num_G;
$err = (length ($dna) - $num_nt);
print "O DNA $dna possui $num_nt nucleotideos\n\n";
print "A = $num_A, T = $num_T, G = $num_G, C = $num_C, Err = $err\n";

# Calcula %AT e %GC
my $AT = ($num_A + $num_T) / $num_nt;
my $CG = 1 - $AT;
print "\%AT = $AT, \%CG = $CG\n";

exit;