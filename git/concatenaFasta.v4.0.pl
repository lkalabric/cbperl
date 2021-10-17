#!/usr/bin/perl
use strict;
use warnings;
use CBPerl;
use Bio::Perl;

# Programa: concatenaFasta.v3.0.pl
# Autor: Luciano Kalabric
# Data: 2020-12-19
# Uso: Extrai dados de um arquivo de sequencias multiplas Fasta

# Valida a entrada de argumentos
my $num_Esperado = 1;			# O número mínimo é 1 para informar o nome do arquivo de entrada
my $num_Argumentos = scalar (@ARGV);
valida_Argumentos ($num_Esperado, $num_Argumentos);

# Declada e inicializa variáveis
my $input_filename = $ARGV[0];
my $num_seq = 0;
my $output_file;
if ($num_Argumentos == 1) {
	$output_file = "output.txt";
}
else {
	$output_file = $ARGV[1];
}

# reads an array of sequences
my @seq_object_array = read_all_sequences($input_filename,'fasta');

# Abre o arquivo de saída de dados 
open (OUTPUTHANDLE, "> $output_file");
# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele

# Imprime os dados no arquivo output.txt
# sequences are Bio::Seq objects, so the following methods work
# for more info see Bio::Seq, or do 'perldoc Bio/Seq.pm'
foreach (@seq_object_array) {
	print OUTPUTHANDLE ">",$_->accession_number(),"\n";
	print OUTPUTHANDLE $_->seq(),"\n";
}

# Fecha o arquivo input_file.txt
close OUTPUTHANDLE ;

# Fim de programa
exit;