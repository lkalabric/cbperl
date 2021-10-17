# DENV1 AF311958.1.gb is a Genbank file, and Bioperl knows that it
# is a Genbank file because of the '.gb' file suffix
use Bio::SeqIO;
my $seqio_object = Bio::SeqIO->new(-file => "DENV1 AF311958.1.gb" );
my $seq_object = $seqio_object->next_seq;

for my $feat_object ($seq_object->get_SeqFeatures) {
    push @ids, $feat_object->get_tag_values("organism") 
       if ($feat_object->has_tag("organism"));
}

for my $feat_object ($seq_object->get_SeqFeatures) {
	if  ($feat_object->primary_tag eq "source") {
		print "primary tag: ", $feat_object->primary_tag, "\n";
	}
    for my $tag ($feat_object->get_all_tags) {
        for my $value ($feat_object->get_tag_values($tag)) {
			if ($tag eq "organism") {
				print "  tag: ", $tag, "\n";
				print "    value: ", $value, "\n";
			}
			if ($tag eq "strain") {
				print "  tag: ", $tag, "\n";
				print "    value: ", $value, "\n";
			}
        }
    }
}

