#!/usr/bin/perl -w
use strict;
use warnings;
# use lib '..\lib'; # Windows
use lib '../lib'; # Linux
use CBPerl;

use Bio::SeqIO; # M�dulo Bio::Perl com filehandle para abrir arquivos de sequencias

# Programa: pcrinsilico.v1.5.pl
# Autor: Luciano Kalabric
# Data YYYY-MM-DD: 2020-05-07
# Uso: Analisa a sensibilidade in silico de primers frente a sequencias pesquisadas no Genbank
# Sintaxe: pcrinsilico.v1.5.pl <primerlist_filename> <refseq_filename>  <output_filename>
# Exemplo: pcrinsilico.v1.5.pl HCV_primerlist.txt HCV1a_sequence.fasta HVC1a_pcrinsilico.out

# system ("cls"); # Windows
system ("clear"); # Linux

# Declara��o de vari�veis
my $primerlist_path = '../data';
my $refseq_path = '../data';  
my $output_path = $primerlist_path;
# my $path_separator = "\\";		# \ for Windows 
my $path_separator = "/"; 	# / for Unix
my $primer;			# Sequencia direta do primer
my $rc_primer;		# Sequencia reversa do primer
my $seq;
my $i; 				# Contador de sequencias
my $j; 				# Contador de matches do primer

# Valida os argumentos
my $command = "cat ~/cbperl/doc/pcrinsilico.v1.5.txt";
(scalar ( @ARGV ) == 3) or die system ($command);
my ($primerlist_filename, $refseq_filename, $output_filename) = @ARGV;	# Argumento(s)					
defined ($primerlist_filename) or $primerlist_filename = "primerlist.fasta";
defined ($refseq_filename) or $refseq_filename = "refseq.fasta";	
defined ($output_filename) or $output_filename = "pcrinsilico.out";	

my $primerlist_fullname = $primerlist_path . $path_separator . $primerlist_filename;
my $refseq_fullname = $refseq_path . $path_separator . $refseq_filename;
my $output_fullname = $output_path . $path_separator . $output_filename;

# L� o arquivo de primers
print "Lendo arquivo ",$primerlist_filename," ... ","\n\n";

# Objeto Bio::Perl que l� arquivos de primers no formato FASTA
my $primerio_obj = Bio::SeqIO->new(-file => $primerlist_fullname, 
                             -format => "fasta" );
my $primer_obj;		# Objeto que ir� receber os dados dos primers

# Output para um arquivo
open (OUTPUTHANDLE, "> ",$output_fullname) or die "N�o foi poss�vel abrir o arquivo ",$output_fullname,"\n\n";
# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele	

# L� as pr�ximas sequencias dos primers no formato FASTA
while ( $primer_obj = $primerio_obj->next_seq ) {
	# Output na tela para acompanhamento do processo
	print "Valida��o in silico do primer ",$primer_obj->display_id()," sequencia ",$primer_obj->seq(),"... \n";
	$primer = $primer_obj->seq();
	$primer =~ s/ //g; 						# Remove possiveis espa�os em branco e
	chomp $primer;							# Remove a qubra de linha \n da sequencia do primer
	my $p_Regexp = IUB2regexp($primer);		# Converte a sequencia do primer em express�o regular
	$rc_primer = revcom($primer); 	# Faz o rc do primer, inclusive degenera��es
	my $rc_Regexp = IUB2regexp($rc_primer);	# Converte a sequencia do rc_primer em express�o regular
		
	# L� o arquivo de sequencias no formato FASTA
	my $seqio_obj = Bio::SeqIO->new(-file => $refseq_fullname, 
                             -format => "fasta" );
	my $seq_obj;							# Variavel que corresponde a sequencia

	# Determina��o da sensibilidade do primer
	# print "Sequencias obtidas do arquivo ",$refseq_filename," ...\n";
	$i = 0;	 								
	$j = 0;		
	while ( $seq_obj = $seqio_obj->next_seq ) {
		if ($seq_obj->seq =~ /$p_Regexp/ or $seq_obj->seq =~ /$rc_Regexp/) {$j++};
		$i++;
	}
	print "o primer ",$primer_obj->display_id()," foi encontrado em ",$j," das ",$i," sequencias.\n\n";

	# Output para o arquivo de sa�da
	print OUTPUTHANDLE $primer_obj->display_id(),"	",$j,"	",$i,"\n";

}
close OUTPUTHANDLE;

# Finaliza o programa
exit;
