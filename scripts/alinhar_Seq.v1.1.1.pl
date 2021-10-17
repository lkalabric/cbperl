#!/usr/bin/perl

use strict;
use warnings;
#use lib '/home/kalabric/cbperl/lib'; # Linux
#use lib '..\cbperl\lib'; # Windows
#use CBPerl;

# Programa: alinhar_Seq.v1.1.pl
# Autor: Luciano Kalabric
# Data: 2018-04-13
# Uso: Alinhamento de um par de sequencias ou multiplas sequencias
# Sintaxe: alinhar_Seq.v1.1.pl in.fas

#system ("cls"); # Windows
system ("clear"); # Linux


# Recebe e valida os argumentos
scalar ( @ARGV ) == 1 or die "Falta algum argumento!\nSintaxe do comando: perl alinhar_Seq.v1.1.pl in.fas\nTodas as sequencias devem estar em um único arquivo FASTA.\n";
my ($inputfilename) = @ARGV;	# Argumento(s)					
defined ($inputfilename) or $inputfilename = 'in.fas';

# Configura o módulo ClustalW para Perl
BEGIN { $ENV{CLUSTALDIR} = '/usr/bin/clustalw' }
use Bio::Tools::Run::Alignment::Clustalw;

#  Objeto Factory para comunicar o Perl com o ClustalW
# my @params = ('quiet' => 1 ); # Sem parametros, apenas silencia o display
my @params = ('ktuple' => 2, outfile => 'outfile.out');	# Parametros para alinhamento de DNA/RNA
# my @params = ('ktuple' => 2, 'matrix' => 'BLOSUM');	# Parametros para alinhamento de proteinas
my $factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);
 
#  Pass the factory a list of sequences to be aligned.
my $aln = $factory->align($inputfilename); # $aln is a SimpleAlign object.
