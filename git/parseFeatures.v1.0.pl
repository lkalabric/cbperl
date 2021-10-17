#!/usr/bin/perl
use strict;
use warnings;
use CBPerl;
use Bio::SeqIO;

# Programa: parseFeatures.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2016-03-25
# Uso: Baixa sequencias do GenBank no formato GenBank e analisa as features
# Sintaxe: perl parseFeatures.v1.0.pl <inputfile.gb> <outputfile.txt>
system("cls");

# Valida a entrada de argumentos e declara variaveis
my $num_Esperado = 1;			# O número mínimo é 1 para informar o nome do arquivo de entrada
my $num_Argumentos = scalar (@ARGV);
valida_Argumentos ($num_Esperado, $num_Argumentos);
my $inputfilename = $ARGV[0];
my $outputfilename;
chomp $inputfilename;

if ($ARGV[1]) {
	$outputfilename = $ARGV[1];
} else {
	$outputfilename = "output.txt";
}

my $num_seq = 0;

# Opções de busca
print "\nPrograma parseFeatures\n\n";
print "Features ";
my $features = ask_user ("all", "country", "type other");

open (OUTPUTHANDLE, "> $outputfilename");
# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele

# Parse file.gb
my $in = Bio::SeqIO->new(-file => $inputfilename, -format => 'genbank') or die "Formato do arquivo incorreto.\n";
while (my $seq_object = $in->next_seq) {
	print OUTPUTHANDLE $seq_object->accession_number,"|";
	for my $feat_object ($seq_object->get_SeqFeatures) {          
		# print "primary tag: ", $feat_object->primary_tag, "\n";          
		for my $tag ($feat_object->get_all_tags) {
			for my $value ($feat_object->get_tag_values($tag)) {                
				if ($features eq "all") {print OUTPUTHANDLE $tag, ": ",$value,"|"}
				elsif ($features eq $tag) { print OUTPUTHANDLE $value}
			}
			
		}   
		
	}
	print OUTPUTHANDLE "\n";
}

close OUTPUTHANDLE ;
# fecha o arquivo output_file.txt
