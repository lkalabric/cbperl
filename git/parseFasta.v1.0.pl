#!/usr/bin/perl
use strict;
use warnings;
use CBPerl;
use Bio::Perl;
use Bio::SeqFeatureI;
use Bio::SeqIO;		

# Programa: parseFasta.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2016-03-25
# Uso: Analisa um arquivo Fasta com uma ou mais sequencias
# Sintaxe: parseFasta.v.1.0.pl <nome_arquivo_Fasta>

# Definição de variáveis e objetos utilizados pelo módulo Bio::DB::Genbank
my $seqio;	# Armazena a sequencia
my $seqobj;	# Armazena a sequencia


# Valida a entrada de argumentos e declara variaveis

# Valida a entrada de parâmetros da linha de comando
scalar ( @ARGV ) == 2 or die "\nA sintáxe do comando está incorreta.\n\n\$ perl program_name input_file_name output_file_name\n\n";

my $num_Esperado = 1;			# O número mínimo é 1 para informar o nome do arquivo de entrada
my $num_Argumentos = scalar (@ARGV);
valida_Argumentos ($num_Esperado, $num_Argumentos);
my $filename = $ARGV[0];
chomp $filename;
my $num_seq = 0;

# gets a sequence from a file
$seqin  = Bio::SeqIO->new( '-format' => 'fasta' , -file => $filename);
# format: fasta, embl, 
# $seqiou  = Bio::SeqIO->new( '-format' => 'fasta' , -file => '>',$filename);
# se o sinal '>' anteceder o argumento com o nome do arquivo, este será aberto para escrita

$seqobj = $seqio->next_seq();

# retrieves information from the sequence
# features must implement Bio::SeqFeatureI interface
my @features = $seqobj->get_SeqFeatures(); # just top level
foreach my $feat ( @features ) {
	print "Feature ",$feat->primary_tag," starts ",$feat->start," ends ",
                     $feat->end," strand ",$feat->strand,"\n";

    # features retain link to underlying sequence object
    print "Feature sequence is ",$feat->seq->seq(),"\n"
}



# sequences are Bio::Seq objects, so the following methods work
# for more info see Bio::Seq, or do 'perldoc Bio/Seq.pm'
#foreach (@seq_object_array) {
#print "Sequence acc  is ",$_->accession_number,"\n";
#print "First 5 bases is ",$_->seq,"\n";
#}

exit;

