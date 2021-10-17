#!/usr/bin/perl
use strict;
# use warnings;

# Programa: exemplo10_parseFasta.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-05-02
# Uso: Extrai dados de um arquivo de sequencias multiplas Fasta
# a) Comando open
# b) operador <filehandle>
# c) while

# Declada e inicializa variáveis
my $input_filename = "input_multiseq_fastaFile.txt";
my $num_seq = 0;
my $linha;
my @fasta_tag;
my @fasta_seq;

# Abre o arquivo Fasta
unless (open (INPUTHANDLE, "$input_filename")) {
	print "Arquivo não encontrado\n:";
	exit;
}

# Associa o nome do arquivo ao filehandle
# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele

# Lê os dados do arquivo, linha-por-linha e armazena o tag e seq em dois array diferenteswhile ($linha = <INPUTHANDLE>) {
$linha = <INPUTHANDLE>;
do {
	chomp $linha;
	if ($linha =~ /^\s*$/) {
		next;
	} elsif ($linha =~ />/) {
		$fasta_tag[$num_seq] = $linha;
		$num_seq++;
		print "Este é o tag da sequencia ",$num_seq,": $fasta_tag[$num_seq-1]\n";
	} else {
		$fasta_seq[$num_seq-1] .= $linha;
	}
	$linha = $_;
} until (<INPUTHANDLE>);
	
# Fecha o arquivo input_fasta.txt
close INPUTHANDLE;

# Fim de programa
exit;