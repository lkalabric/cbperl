use LWP::Simple;
use Bio::DB::GenBank;
$gb = Bio::DB::GenBank->new();
 
$seq = $gb->get_Seq_by_id('J00522'); # Unique ID, *not always the LOCUS ID*
 
# or ...
 
$seq = $gb->get_Seq_by_acc('J00522'); # Accession Number
$seq = $gb->get_Seq_by_version('J00522.1'); # Accession.version
$seq = $gb->get_Seq_by_gi('405830'); # GI Number
 
# get a stream via a query string
my $query = Bio::DB::Query::GenBank->new
    (-query   =>'Oryza sativa[Organism] AND EST',
     -reldate => '30',
     -db      => 'nucleotide');
my $seqio = $gb->get_Stream_by_query($query);
 
while( my $seq =  $seqio->next_seq ) {
  print "seq length is ", $seq->length,"\n";
}
 
# or ... best when downloading very large files, prevents
# keeping all of the file in memory
 
# also don't want features, just sequence so let's save bandwidth
# and request Fasta sequence
$gb = Bio::DB::GenBank->new(-retrievaltype => 'tempfile' ,
                                          -format => 'Fasta');
my $seqio = $gb->get_Stream_by_acc(['AC013798', 'AC021953'] );
while( my $clone =  $seqio->next_seq ) {
  print "cloneid is ", $clone->display_id, " ",
         $clone->accession_number, "\n";
}
# note that get_Stream_by_version is not implemented
 
# don't want the entire sequence or more options
my $gb = Bio::DB::GenBank->new(-format     => 'Fasta',
                               -seq_start  => 100,
                               -seq_stop   => 200,
                               -strand     => 1,
                               -complexity => 4);
my $seqi = $gb->get_Stream_by_query($query);