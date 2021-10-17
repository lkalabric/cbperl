#!/usr/bin/perl

use strict;
use warnings;
#use lib '/home/kalabric/cbperl/lib'; # Linux
#use lib '..\cbperl\lib'; # Windows
#use CBPerl;

# Programa: alinhar_Seq.v1.1.pl
# Autor: Luciano Kalabric
# Data: 2018-04-13
# Uso: Alinhamento de um par de sequencias
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
my @params = ('ktuple' => 2);	# Parametros para alinhamento de DNA/RNA
# my @params = ('ktuple' => 2, 'matrix' => 'BLOSUM');	# Parametros para alinhamento de proteinas
my $factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);
 
#  Pass the factory a list of sequences to be aligned.
my $aln = $factory->align($inputfilename); # $aln is a SimpleAlign object.
# or
# my $seq_array_ref = \@seq_array;
# where @seq_array is an array of Bio::Seq objects
# $aln = $factory->align($seq_array_ref);

# Salva o alinhamento em um arquivo
my $out = Bio::AlignIO->new(-file   => ">out.aln" ,
                         -format => 'fasta');
 
foreach my $seq ($aln->each_seq) {
	print $seq,"\n";
    $out->write_aln($seq);
}

# Descreve o alinhamento
print "Length: ",$aln->length,"\n";
print "Number of sequences: ",$aln->num_sequences,"\n";
print "Score: ",$aln->score,"\n";
print "Percentage of identity: ",$aln->percentage_identity,"\n";

# Find the position in the alignment for a sequence location
my $pos = $aln->column_from_residue_number('939', 14); # = 6;

 
# Extract sequences and check values for the alignment column $pos
my $res;
my $count;
my %count;
foreach my $seq ($aln->each_seq) {
    $res = $seq->subseq($pos, $pos);
    $count{$res}++;
}

foreach $res (keys %count) {
    printf "Res: %s  Count: %2d\n", $res, $count{$res};
}

# Or one can pass the factory a pair of (sub)alignments
#to be aligned against each other, e.g.:
# $aln = $factory->profile_align($aln1,$aln2);
# where $aln1 and $aln2 are Bio::SimpleAlign objects.
 
# Or one can pass the factory an alignment and one or more unaligned
# sequences to be added to the alignment. For example:
# $aln = $factory->profile_align($aln1,$seq); # $seq is a Bio::Seq object.
 
# Get a tree of the sequences
# my $tree = $factory->tree(\@seq_array);
 
# Get both an alignment and a tree
# ($aln, $tree) = $factory->run(\@seq_array);
 
# Do a footprinting analysis on the supplied sequences, getting back the
# most conserved sub-alignments
# my @results = $factory->footprint(\@seq_array);
# foreach my $result (@results) {
#  print $result->consensus_string, "\n";
#}
 
# There are various additional options and input formats available.
# See the DESCRIPTION section that follows for additional details.


sub abrir_ArquivoSequencias{
# Objeto filehandle para abrir o arquivo
	my $seqio  = Bio::SeqIO->new(-file => "in.fas" ,
                               -format => 'Fasta');
        
	my $seqlabel;
	my $seqstr;
	my $rev;
	my $seqrev;
	# Objeto sequencia para armazenar cada sequencia do arquivo
	while ( my $seqobj = $seqio->next_seq() ) {
	   $seqlabel = $seqobj->display_id();
	   $seqstr = $seqobj->seq();
	   $rev = $seqobj->revcom; # revcom retorna um objeto contendo o reverso completemento da sequencia
	   $seqrev = $rev->seq();
	   print $seqlabel," ",$seqstr," ",$seqrev,"\n";
	}
}

sub alinhar_Sequencias {
	BEGIN { $ENV{CLUSTALDIR} = '/usr/bin/clustalw' }
	use Bio::Tools::Run::Alignment::Clustalw;

	#  Build a clustalw alignment factory
	  my @params = ('ktuple' => 2, 'matrix' => 'BLOSUM');
	  my $factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);

	  #  Pass the factory a list of sequences to be aligned.
	  my $inputfilename = 'in.fas';
	  my $aln = $factory->align($inputfilename); # $aln is a SimpleAlign object.
	  # or
	  my @seq_array;
	  my $seq_array_ref = \@seq_array;
	  # where @seq_array is an array of Bio::Seq objects
	  $aln = $factory->align($seq_array_ref);

	  # Or one can pass the factory a pair of (sub)alignments
	  #to be aligned against each other, e.g.:
	  $aln = $factory->profile_align(my $aln1, my $aln2);
	  # where $aln1 and $aln2 are Bio::SimpleAlign objects.

	  # Or one can pass the factory an alignment and one or more unaligned
	  # sequences to be added to the alignment. For example:
	  $aln = $factory->profile_align($aln1,my $seq); # $seq is a Bio::Seq object.

	  # Get a tree of the sequences
	  my $tree = $factory->tree(\@seq_array);

	  # Get both an alignment and a tree
	  ($aln, $tree) = $factory->run(\@seq_array);

	  # Do a footprinting analysis on the supplied sequences, getting back the
	  # most conserved sub-alignments
	  my @results = $factory->footprint(\@seq_array);
	  foreach my $result (@results) {
		print $result->consensus_string, "\n";
	  }

	  # There are various additional options and input formats available.
	  # See the DESCRIPTION section that follows for additional details.
}

# Analisa um arquivo de alinhamento
sub analisar_Alinhamento {
use Bio::AlignIO; # to read in the alignment
      my $str = Bio::AlignIO->new(-file => 'out.fas');
      $aln = $str->next_aln();
	
      # Describe
      print $aln->num_sequences,"\n";
      print $aln->percentage_identity,"\n";
      	  
      # Find the position in the alignment for a sequence location
      $pos = $aln->column_from_residue_number('939', 1); # = 6;
	  print $pos,"\n";
	  
      # Extract sequences and check values for the alignment column $pos
      my $seqfasta;
	  foreach my $seq ($aln->each_seq) {
		$seqfasta = $aln->each_seq;
		print $seqfasta,"\n";
		$res = $seq->subseq($pos,$pos+20);
        #print $count{$res}++;
		#print $res,"\n";
  	  }
} 
