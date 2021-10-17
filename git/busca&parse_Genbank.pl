#!/usr/bin/perl
use strict;
use Bio::DB::GenBank;			# Acesso a banco de dados
use Bio::DB::Query::GenBank;	# Acesso a banco de dados
use Bio::SeqIO;					# Parse dos dados das sequencias

system ("cls");

# Entrada da query através do teclado
print "Busca por palavras no Genbank nuccoreDB (ex. HCV complete genome):\n";
my $query = <STDIN>;
chomp $query;
$query =~ s/\s/ AND /g;							# Substitui o espaço por "+" (conectivo AND)
$query .= " and 9000:10000[SLEN]";				# Limita sequencias entre 9.000 e 10.000 nt de comprimento

# Objetos para busca e download das sequencias do Genbank
my $query_obj = Bio::DB::Query::GenBank->new(-db => 'nucleotide', 
                                          -query => $query );
my $gb_obj = Bio::DB::GenBank->new;
my $stream_obj = $gb_obj->get_Stream_by_query($query_obj);

# Objeto para armazenar os dados da sequencia
my $seq_obj;

# Baixa a sequencia encontrada e faz o parse os dados de interesse
while ($seq_obj = $stream_obj->next_seq) {
    # Imprime os dados básicos de uma sequencia    
    print ">",$seq_obj->display_id, "\t", $seq_obj->desc, "\t",$seq_obj->length, "\t", $seq_obj->get_dates,"\t", $seq_obj->seq,"\t";
	
	# Imprime algumas features de uma sequencia
	for my $feat_object ($seq_obj->get_SeqFeatures) {
		if  ($feat_object->primary_tag eq "source") {
			for my $tag ($feat_object->get_all_tags) {
				for my $value ($feat_object->get_tag_values($tag)) {
					if ($tag eq "organism") {print $value,"\t";} else { print "\t"} 
					if ($tag eq "isolate") {print $value,"\t";} else { print "\t"} 
					if ($tag eq "country") {print $value,"\t";} else { print "\t"} 
					if ($tag eq "subtype") {print $value,"\t";} else { print "\t"} 
					if ($tag eq "genotype") {print $value,"\t";} else { print "\t"} 
				}
			}		
		}
		
	}
	print "\n";
}

# Fim do programa
exit;