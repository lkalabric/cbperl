#!/usr/bin/perl -w
use strict;
use warnings;
# use lib '..\lib'; # Windows
use lib '../lib'; # Linux
use CBPerl;
use Bio::Seq;
use Bio::SeqIO; # Módulo Bio::Perl com filehandle para abrir arquivos de sequencias

# Programa: anota_Primer.v2.0.pl
# Autor: Luciano Kalabric
# Data: 2019-12-28
# Uso: Anota primers em uma sequencia referencia por busca literal e por expressão regular e gera arquivo no formato .gff
# Sintaxe: anota_Primer.v2.0.pl primers.fasta Refseq.fasta anotaPrimer.gff

#system ("cls"); # Windows
system ("clear"); # Linux

# Define path de entrada e saída de dados
# Para Windows						# Caminho padrão de dados de entrada e saída
# my $input_path = 'data\';			# Substituir por outro caminho de entrada
# my $output_path = $input_path;	# Substituir por outro caminho de saída
# my $path_separator = "\";

# Para Unix/Linux					# Caminho padrão de dados de entrada e saída
my $input_path = '../data';			# Substituir por outro caminho de entrada
my $output_path = $input_path;		# Substituir por outro caminho de saída
my $path_separator = "/";

# Declara variaveis
my $primer;				# Sequencia direta do primer
my $rc_primer;			# Sequencia reversa do primer

# Valida os argumentos
my $command = "cat ~/cbperl/doc/anota_Primer.v2.0.txt";
(scalar ( @ARGV ) == 3) or die system ($command);

# Parei aqui!!!
my ($primer_filename, $refseq_filename, $annotation_filename) = @ARGV;	# Argumento(s)					
defined ($primer_filename) or $primer_filename = "primerlist.txt";
defined ($refseq_filename) or $refseq_filename = "refseq.fasta";	
defined ($annotation_filename) or $annotation_filename = "anotaPrimer.gff";	

# Define o nome completo dos arquivos de entrada e saída com o path (somente Linux)
my $primer_fullname = $input_path . $path_separator . $primer_filename;
my $refseq_fullname = $output_path . $path_separator . $refseq_filename;
my $annotation_fullname = $output_path . $path_separator . $annotation_filename;

# Lê o arquivo da refseq
print "Os primers serão anotados na sequencia referencia ",$refseq_filename,"... \n";

# Handle para leitura da refseq
my $seqio_obj = Bio::SeqIO->new(-file => $refseq_fullname, 
                             -format => "fasta" );
my $seq_obj = $seqio_obj->next_seq();	# Objeto que irá armazenar a refseq
my $seq =  $seq_obj->seq;

# Lê o arquivo do primer
print "Lendo o(s) primer(s) do arquivo ",$primer_fullname," ... ","\n";

# Handle para leitura das sequencias dos primers
my $primerio_obj = Bio::SeqIO->new(-file => $primer_fullname, 
                             -format => "fasta" );
my $primer_obj;			# Objeto que irá armazenar as sequencias dos primers


# Handle para output dos resultados
open (OUTPUTHANDLE, "> ",$annotation_fullname) or die "Não foi possível abrir o arquivo ",$annotation_filename,"\n\n";
# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele	
print OUTPUTHANDLE "##Annotation of primers to the Referense Sequence ",$seq_obj->display_id,"\n";

my $start;
my $stop;
my $p_Regexp;
my $rc_Regexp;
# Loop que anota cada primer na refseq
while ( $primer_obj = $primerio_obj->next_seq() ) {
	# Output na tela para acompanhamento do processo
	print "Anotação do primer ",$primer_obj->display_id," sequencia ",$primer_obj->seq(),"... \n";
	$primer = $primer_obj->seq();
	$primer =~ s/ //g; 			# Remove possiveis espaços em branco e
	chomp $primer;				# Remove a qubra de linha \n da sequencia do primer
	$p_Regexp = IUB2regexp($primer);	# Converte a sequencia do primer em expressão regular
	$rc_primer = revcom($primer); 		# Faz o rc do primer, inclusive degenerações
	$rc_Regexp = IUB2regexp($rc_primer);	# Converte a sequencia do rc_primer em expressão regular
	# Busca primer por expressão regular na sequencia referencia
	if ( $seq =~ /$p_Regexp/g ) {
		$stop = pos ($seq);
		$start = $stop - length ($primer) + 1;
		# Output para STDOUT
		print "O primer ",$primer_obj->display_id," foi anotado com sucesso!\n\n";	
		# Output para o arquivo de saída
		print OUTPUTHANDLE $primer_obj->display_id,"\t","anotaPrimer\t","primer_bind\t",$start,"\t",$stop,"\t.\t+\t.\tID=",$primer_obj->display_id;	
	} elsif ( $seq =~ /$rc_Regexp/g ) {
		$stop = pos ($seq);
		$start = $stop - length ($primer) + 1;
		# Output para STDOUT
		print "O primer ",$primer_obj->display_id," foi anotado com sucesso!\n\n";	
		# Output para o arquivo de saída
		print OUTPUTHANDLE $primer_obj->display_id,"\t","anotaPrimer\t","primer_bind\t",$start,"\t",$stop,"\t.\t-\t.\tID=",$primer_obj->display_id,"\n";	
	} else {
		# Output para STDOUT	
		print "O primer ",$primer_obj->display_id," não foi encontrado!\n\n";
	}

}
close OUTPUTHANDLE;

# Finaliza o programa
exit;
