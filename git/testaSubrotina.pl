#!/usr/bin/perl
use CBPerl;		# Biblioteca desenvolvido neste curso 
use strict; 	# Bibliotecas padrões para debug do programa
use warnings; 	# 

# Programa: testaSubrotina.pl
# Autor: Luciano Kalabric
# Data: 2017-06-15
# Uso: Testar ssubrotinas

# Input
my $nomeArquivo = "input_motifs.txt";

# Testa Subrotina
my @motifs = le_Arquivo($nomeArquivo);

# Output
foreach (@motifs) {print $_;}

close;
