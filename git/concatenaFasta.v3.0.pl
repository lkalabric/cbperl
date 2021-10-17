#!/usr/bin/perl
use strict;
use warnings;
use CBPerl;

# Programa: concatenaFasta.v3.0.pl
# Autor: Luciano Kalabric
# Data: 2016-03-25
# Uso: Extrai dados de um arquivo de sequencias multiplas Fasta

# Valida a entrada de argumentos
my $num_Esperado = 1;			# O número mínimo é 1 para informar o nome do arquivo de entrada
my $num_Argumentos = scalar (@ARGV);
valida_Argumentos ($num_Esperado, $num_Argumentos);

# Declada e inicializa variáveis
my $input_filename = $ARGV[0];
my $num_seq = 0;
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
my @linha = <INPUTHANDLE>;
foreach (@linha) {
	chomp $_;
	if ($_ =~ /^\s*$/) {
		next;
	} elsif ($_ =~ />/) {
		$fasta_tag[$num_seq] = $_;
		$num_seq++;
	} else {
		$fasta_seq[$num_seq-1] .= $_;
	}
}
	
# Fecha o arquivo input_fasta.txt
close INPUTHANDLE;

# Imprime relatório sobre os dados processados
print "Um total de ",$num_seq," sequencias foram processadas.\n";

# Valida a entrada de argumentos
my $output_file;
if ($num_Argumentos == 1) {
	$output_file = "output.txt";
}
else {
	$output_file = $ARGV[1];
}

# Abre o arquivo de saída de dados 
open (OUTPUTHANDLE, "> $output_file");
# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele

# Imprime os dados no arquivo output.txt
for(0..$num_seq-1) {
	print OUTPUTHANDLE $fasta_tag[$_],"\n";
	print OUTPUTHANDLE $fasta_seq[$_],"\n\n";
}

# Fecha o arquivo input_file.txt
close OUTPUTHANDLE ;

# Fim de programa
exit;