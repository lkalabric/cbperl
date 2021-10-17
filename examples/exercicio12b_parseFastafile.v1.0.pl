#!/usr/bin/perl
use strict;
use warnings;
use Bio::FASTASequence;
use Bio::FASTASequence::File;

# Programa: exercicio12_parseFastafile.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-05-02
# Uso: Extrai dados de um arquivo multiplo de sequencias Fasta
# a) use Bio::FASTASequende::File

my $filename = "sequenceProt.fasta"; # armazena o nome do arquivo de entrada de dados
# my $parsed_fasta = Bio::FASTASequence::File->new($filename);
# $parsed_fasta->file($filename);
# my $hashref = $parsed_fasta->get_result();


# or
my $parsed = Bio::FASTASequence::File->new();
my $hashref = $parsed->file($filename);

print $hashref,"\n";



# if a sequence with accession_nr H23OP3 is in the file (as an example)
# these methods are the methods from Bio::FASTASequence
# my $crc64 = $hashref->{H23OP3}->getCRC64();
# my $sequence = $hashref->{H23OP3}->getSequence();


# Fim do programa
exit;