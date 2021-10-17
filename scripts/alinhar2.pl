#!/usr/bin/perl

use Bio::Seq;
use Bio::SeqIO;

@seq_array = abrir_ArquivoSequencias();
alinhar_Sequencias(@seq_array);
# analisar_Alinhamento();

exit;


sub abrir_ArquivoSequencias{
# Objeto filehandle para abrir o arquivo
	$seqio  = Bio::SeqIO->new(-file => "in.fas" ,
                               -format => 'Fasta');
        @seq_array=();
	# Objeto sequencia para armazenar cada sequencia do arquivo
	while ( my $seqobj = $seqio->next_seq() ) {
	    push (@seq_array,$seqobj);
	   $seqlabel = $seqobj->display_id();
	   $seq = $seqobj->seq();
	   $rev = $seqobj->revcom; # revcom retorna um objeto contendo o reverso completemento da sequencia
	   $seqrev = $rev->seq();
	   print $seqlabel,"\n",$seq,"\n",$seqrev,"\n";
	}
	return @seq_array;
}
exit;

sub alinhar_Sequencias {
	BEGIN { $ENV{CLUSTALDIR} = '/usr/bin/clustalw' }
	use Bio::Tools::Run::Alignment::Clustalw;
	@seq_array = @_;
	#  Build a clustalw alignment factory
	# Parametros uteis para alinhamento de sequencias de proteinas  
	# @params = ('ktuple' => 2, 'matrix' => 'BLOSUM');
	# Parametros uteis para alinhamento de sequencias de nucleotideos
	@params = ('ktuple' => 4, 'quiet' => 1, 'outfile' => 'out.aln');
	$factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);

	  #  Pass the factory a list of sequences to be aligned.
	  # $inputfilename = 'in.fas';
	  # $aln = $factory->align($inputfilename); # $aln is a SimpleAlign object.
	  # or
	$seq_array_ref = \@seq_array;
	  # where @seq_array is an array of Bio::Seq objects
	$aln = $factory->align($seq_array_ref);

	  # Or one can pass the factory a pair of (sub)alignments
	  # to be aligned against each other, e.g.:
	  # $aln = $factory->profile_align($aln1,$aln2);
	  # where $aln1 and $aln2 are Bio::SimpleAlign objects.

	  # Or one can pass the factory an alignment and one or more unaligned
	  # sequences to be added to the alignment. For example:
	  # $aln = $factory->profile_align($aln1,$seq); # $seq is a Bio::Seq object.

	  # Get a tree of the sequences
	  # $tree = $factory->tree(\@seq_array);

	  # Get both an alignment and a tree
	  # ($aln, $tree) = $factory->run(\@seq_array);

	  # Do a footprinting analysis on the supplied sequences, getting back the
	  # most conserved sub-alignments
	  @results = $factory->footprint(\@seq_array);
	  foreach $result (@results) {
	   	print $result->consensus_string, "\n";
	  }

	  # There are various additional options and input formats available.
	  # See the DESCRIPTION section that follows for additional details.

      # Descreve o alinhamento 
      print "Numero de sequencias: ", $aln->num_sequences,"\n";
      print "Identidade: ",$aln->percentage_identity,"\n";
      print "Score: ",$aln->score,"\n";	  
}
 
# Subrotina para analisa um arquivo de alinhamento
sub analisar_Alinhamento {
use Bio::AlignIO; # to read in the alignment
      $str = Bio::AlignIO->new(-file => 'out.fas');
      $aln = $str->next_aln();
	
      # Describe
      print $aln->num_sequences,"\n";
      print $aln->percentage_identity,"\n";
      	  
      # Find the position in the alignment for a sequence location
      $pos = $aln->column_from_residue_number('939', 1); # = 6;
	  print $pos,"\n";
	  
      # Extract sequences and check values for the alignment column $pos
      foreach $seq ($aln->each_seq) {
		$seqfasta = $aln->each_seq;
		print $seqfasta,"\n";
		$res = $seq->subseq($pos,$pos+20);
        #print $count{$res}++;
		#print $res,"\n";
  	  }
} 
