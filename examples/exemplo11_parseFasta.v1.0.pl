#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo11_parseFasta.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Extrai dados de um arquivo de sequencias multiplas Fasta
# a) Comando open
# b) operador <filehandle>
# c) while
# Sintaxe: perl exemplo11_parseFasta.v1.0.pl

# Declada e inicializa variáveis
my $input_filename = "input_multiseq_fastaFile.txt";
my @fasta_tag;
my @fasta_seq;
my %sequencia;
# Abre o arquivo Fasta
unless (open (INPUTHANDLE, "$input_filename")) {
	print "Arquivo não encontrado\n:";
	exit;
}

# Lê os dados do arquivo, linha-por-linha e armazena o tag e seq em dois array diferenteswhile ($linha = <INPUTHANDLE>) {
my @linha = <INPUTHANDLE>;
my $i_seq = -1; 	# Índice de sequencias
foreach (@linha) {
	chomp $_;
	if ($_ =~ /^\s*$/) {
		next;
	} elsif ($_ =~ />/) {
		$i_seq++;
		$fasta_tag[$i_seq] = $_;
		
		next;
	} else {
		$fasta_seq[$i_seq] .= $_; # Concatena as linhas de sequencia numa única sequencia
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
     print "$key: $sequencia{$key}\n";
}

# Fim de programa
exit;