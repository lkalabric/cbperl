#!/usr/bin/perl
use strict;
use warnings;
use lib '/home/kalabric/cbperl/lib'; # Linux
#use lib '..\cbperl\lib'; # Windows
use CBPerl;

use Bio::Perl;
use Bio::Seq;
use Bio::SeqIO; # Módulo Bio::Perl com filehandle para abrir arquivos de sequencias

# Programa: alinhar_Primer.v1.1.pl
# Autor: Luciano Kalabric
# Data: 2020-12-19
# Uso: Analisa a sensibilidade in silico de primers frente a sequencias pesquisadas no Genbank
# Sintaxe: alinhar_Primer.v1.1.pl primers.txt sequence.fasta

#system ("cls"); # Windows
system ("clear"); # Linux

# Declara variaveis
my $primer;			# Sequencia direta do primer
my $rc_primer;		# Sequencia reversa do primer
my $seq;
my $i; 				# Contador de sequencias
my $j; 				# Contador de matches do primer

# Validação dos argumentos
scalar ( @ARGV ) == 2 or die "Falta algum argumento!\nSintaxe do comando: perl alinhar_Primer.v1.1.pl primerlist.txt refseq.fas\n";
my ($primer_filename, $fasta_filename) = @ARGV;	# Argumento(s)					
defined ($primer_filename) or $primer_filename = "primerlist.txt";
defined ($fasta_filename) or $fasta_filename = "HCV1a_M62321.fas";	

# Cria o arquivo de sequencias no formato FASTA contendo a refseq e o primer


# Alinha as sequencias

# 

use Bio::AlignIO;

    $inputfilename = "HCV1a_M62321.fas";
    $in  = Bio::AlignIO->new(-file   => $inputfilename ,
                             -format => 'fasta');
    $out = Bio::AlignIO->new(-file   => ">out.aln" ,
                             -format => 'fasta');

    while ( my $aln = $in->next_aln() ) {
        $out->write_aln($aln);
    }


# Finaliza o programa
exit;
