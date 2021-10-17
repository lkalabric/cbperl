#!/usr/bil/perl
use Bio::Perl;

$database = 'genbank';
@acc = ('M62321.1','X04615.1');
$format = 'fasta';
$filename = 'baixa_ACC.out';
foreach (@acc) {
	$seq_obj = get_sequence($database,$_);
	write_sequence(">$filename",$database,$seq_obj);
}
exit 0;