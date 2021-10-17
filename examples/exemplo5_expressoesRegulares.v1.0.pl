#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo5_expressoesRegulares.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Aprender como construir expressões regulares Perl
# a) Uso expressões regulares
# b) Uso função pos
# c) Uso função length
# Sintaxe: perl exemplo5_expressoesRegulares.v.1.0.pl

# Declara a variavel $seq e inicializa com a sequencia do DNA
my $seq = "ATGCTTATGCTAGTACTGGCAGTCAACTTTTTGGCTATATTATCGATATATA";
print "Sequencia: $seq\n\n";

# Declara a variavel $expressao
my $expressao;

# ? - busca zero ou um T
$expressao = "ACT?G"; # busca ACG ou ACTG
if ($seq =~ /$expressao/ig) {
	print "$& encontrada na posição ".(pos($seq) - length($&) + 1)."\!\n";
} else {
	print $&," não encontrada!\n";
}

# * -  busca zero ou mais Ts
$expressao = "ACT*G"; # busca ACG, ACTTG, ACTTTG...
if ($seq =~ /$expressao/ig) {
	print "$expressao encontrada na posição ".(pos($seq) - length($&) + 1)."\!\n";
} else {
	print $expressao," não encontrada!\n";
}

# + - busca um ou mais Ts
$expressao = "ACT+G"; # busca ACTG, ACTTG, ACTTTG...
if ($seq =~ /$expressao/ig) {
	print "$expressao encontrada na posição ".(pos($seq) - length($&) + 1)."\!\n";
} else {
	print $expressao," não encontrada!\n";
}

# {n} - busca exatamente ‘n’ ocorrências
$expressao = "ACT{5}G"; # busca ACTTTTTG
if ($seq =~ /$expressao/ig) {
	print "$expressao encontrada na posição ".(pos($seq) - length($&) + 1)."\!\n";
} else {
	print $expressao," não encontrada!\n";
}

# {n,} - busca ‘n’ ou mais ocorrências
$expressao = "ACT{5,}"; # busca ACTTTTT, ACTTTTTT,...
if ($seq =~ /$expressao/ig) {
	print "$expressao encontrada na posição ".(pos($seq) - length($&) + 1)."\!\n";
} else {
	print $expressao," não encontrada!\n";
}

# {n,m} - busca entre ‘n’ e ‘m’ ocorrências
$expressao = "ACT{1,3}"; # busca ACTG, ACTTG, ACTTTG
if ($seq =~ /$expressao/ig) {
	print "$expressao encontrada na posição ".(pos($seq) - length($&) + 1)."\!\n";
} else {
	print $expressao," não encontrada!\n";
}

# Construa suas próprias expressões regulare e teste-as aqui

# Fim do programa
exit;