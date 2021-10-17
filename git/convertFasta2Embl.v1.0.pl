#!/usr/bin/perl
use strict;
use warnings;
use Bio::SeqIO;

# Programa: convertFasta2Embl.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2016-03-25
# Uso: Converte um arquivo fasta em embl

#Entrada de dados através de argumento na linha de comando
scalar (@ARGV) == 1 or die "Sintaxe do comando incorreta.\n";

my $inputfilename = $ARGV[0];
my $outputfilename = "output.txt";

my $in  = Bio::SeqIO->new(-file => "$inputfilename" ,
                               -format => 'Fasta');
my $out = Bio::SeqIO->new(-file => "> $outputfilename" ,
                               -format => 'EMBL');

while ( my $seq = $in->next_seq() ) {
    $out->write_seq($seq);
}
