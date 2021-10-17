#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo11_parseFastafile.v2.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Le um arquivo Fasta com m�ltiplas sequencias
# a) Comando open
# b) operador <filehandle>
# c) while
# Sintaxe: perl exemplo11_parseFastafile.v2.0.pl

# Declada e inicializa vari�veis
my $input_filename = "input_multiseq_fastaFile.txt";
my @fasta_tag;
my @fasta_seq;
my %sequencia;
# Abre o arquivo Fasta
unless (open (INPUTHANDLE, "$input_filename")) {
	print "Arquivo n�o encontrado\n:";
	exit;
}

# L� os dados do arquivo, linha-por-linha e armazena o tag e seq em dois array diferentes
my @linha = <INPUTHANDLE>;
my $i_seq = -1; 	# �ndice de sequencias
foreach (@linha) {
	chomp $_;
	if ($_ =~ /^\s*$/) {
		next;
	} elsif ($_ =~ />/) {
		$i_seq++;
		$fasta_tag[$i_seq] = $_;
		next;
	} else {
		$fasta_seq[$i_seq] .= $_; # Concatena as linhas de sequencia numa �nica sequencia
	}
}

# Fecha o arquivo input_fasta.txt
close INPUTHANDLE;

# Lista as sequencias armazenadas no array e converte em hash
my $i;
for ($i = 0; $i <= $i_seq; $i++) {
	print $fasta_tag[$i],"\n";
	print $fasta_seq[$i],"\n";
	$sequencia{$fasta_tag[$i]} = $fasta_seq[$i];
}

# Lista as sequencias armazenadas no hash
foreach my $key (sort keys %sequencia) {
     print "$key\n$sequencia{$key}\n";
}

# Fim de programa
exit;