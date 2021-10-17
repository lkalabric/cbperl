#!/bin/perl -w

use Bio::SeqIO;

# Tutorial Bio Perl http://bioperl.org/howtos/Beginners_HOWTO.html#item12

# Prepara o módulo Bio::SeqIO do BioPerl para leitura do arquivo
$seqio_obj = Bio::SeqIO->new(-file => "output_efetchId.txt", 
                             -format => "fasta" );

# Lê a sequencia propriamente
$seq_obj = $seqio_obj->next_seq;

# Imprime as sequencias lidas
while ( $seq_obj = $seqio_obj->next_seq ) {
    # print the sequence
    # print $seq_obj->seq,"\n";
	# print $seq_obj->seq,"\n";
	print $seq_obj->acc,"\n";
}

exit;