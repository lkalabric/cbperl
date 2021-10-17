#!/usr/bin/perl
use strict;
use warnings;
use lib '../lib';
use CBPerl;

# Programa: busca_Genbank.v1.1.pl
# Autor: Luciano Kalabric
# Data: 2016-09-30
# Uso: Busca no Genbank e faz download de dados de nucleotideos no formato FASTA
# Sintaxe: busca_Genbank.v1.1.pl

# system ("cls");

# Entrada da query através do teclado
print "Busca por palavras no Genbank nuccoreDB (ex. HCV complete genome):\n";
my $query = <STDIN>;
chomp $query;
$query =~ s/\s/+/g;									# Substitui o espaço por "+" (conectivo AND)

# E-Utilities Basic Pipeline
# Busca e faz o download das sequencias Fasta para o arquivo output_efetchId.txt
my $db =  "nucleotide";
esearch_Genbank ($query, $db); 						# Busca $query e armazena a lista de UIDs no arquivo output_esearch.txt
my ($id_list) = parse_esearchfile();				# Analisa o arquivo output_esearch.txt e armazena os Ids num array
efetchId_Genbank ($id_list, $db);					# Baixa as sequencias e armazena no arquivo output_efetchId.txt

print STDERR "\nDownload das sequencias para o arquivo output_efetchId.txt concluído! Pressione Enter para continuar..."; scalar <STDIN>;
print "\n";

# Finaliza o programa
exit;
