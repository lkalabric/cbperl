#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo5_expressoesRegulares.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Aprender como construir express�es regulares Perl
# a) Uso express�es regulares
# b) Uso fun��o pos
# c) Uso fun��o length
# Sintaxe: perl exemplo5_expressoesRegulares.v.1.0.pl

# Declara a variavel $seq e inicializa com a sequencia do DNA
my $seq = "ATGCTTATGCTAGTACTGGCAGTCAACTTTTTGGCTATATTATCGATATATA";
print "Sequencia: $seq\n\n";

# Declara a variavel $expressao
my $expressao;

# ? - busca zero ou um T
$expressao = "ACT?G"; # busca ACG ou ACTG
if ($seq =~ /$expressao/ig) {
	print "$& encontrada na posi��o ".(pos($seq) - length($&) + 1)."\!\n";
} else {
	print $&," n�o encontrada!\n";
}

# * -  busca zero ou mais Ts
$expressao = "ACT*G"; # busca ACG, ACTTG, ACTTTG...
if ($seq =~ /$expressao/ig) {
	print "$expressao encontrada na posi��o ".(pos($seq) - length($&) + 1)."\!\n";
} else {
	print $expressao," n�o encontrada!\n";
}

# + - busca um ou mais Ts
$expressao = "ACT+G"; # busca ACTG, ACTTG, ACTTTG...
if ($seq =~ /$expressao/ig) {
	print "$expressao encontrada na posi��o ".(pos($seq) - length($&) + 1)."\!\n";
} else {
	print $expressao," n�o encontrada!\n";
}

# {n} - busca exatamente �n� ocorr�ncias
$expressao = "ACT{5}G"; # busca ACTTTTTG
if ($seq =~ /$expressao/ig) {
	print "$expressao encontrada na posi��o ".(pos($seq) - length($&) + 1)."\!\n";
} else {
	print $expressao," n�o encontrada!\n";
}

# {n,} - busca �n� ou mais ocorr�ncias
$expressao = "ACT{5,}"; # busca ACTTTTT, ACTTTTTT,...
if ($seq =~ /$expressao/ig) {
	print "$expressao encontrada na posi��o ".(pos($seq) - length($&) + 1)."\!\n";
} else {
	print $expressao," n�o encontrada!\n";
}

# {n,m} - busca entre �n� e �m� ocorr�ncias
$expressao = "ACT{1,3}"; # busca ACTG, ACTTG, ACTTTG
if ($seq =~ /$expressao/ig) {
	print "$expressao encontrada na posi��o ".(pos($seq) - length($&) + 1)."\!\n";
} else {
	print $expressao," n�o encontrada!\n";
}

# Construa suas pr�prias express�es regulare e teste-as aqui

# Fim do programa
exit;