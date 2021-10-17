#!/usr/bin/perl
use strict;
use warnings;
use CBPerl;

# Programa: exemplo_traduzFrame.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-05-02
# Uso: Traduz uma região especifica do DNA (início e fim)
# Sintaxe: perl exemplo_traduzFrame.v1.0.pl <inicio> <fim>
# a) Uso da função substr

# Inicializa variáveis
my $dna = 'CGACGTCTTCGTACGGGACTAGCTCGTGTCGGTCGC';

# Verifica os argumentos
unless (scalar (@ARGV) >= 1) {
	print "Este programa necessita de pelo menos de um argumento: início da sequencia\n";
	exit;
}
# Recebe os arqumentos
my ($inicio, $fim) = @ARGV;

unless ($fim) {
	$fim = length ($dna);
}

my $proteina = traduz_DNA2protein (substr($dna,$inicio-1,$fim));

print "\nDNA: $dna\n\nProteina traduzida:$proteina\n\n";
exit;
