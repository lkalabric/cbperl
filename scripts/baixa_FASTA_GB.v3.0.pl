#!/usr/bin/perl -w

use strict;
use warnings;
use Bio::DB::GenBank;	# Database object interface to GenBank

# Programa: baixa_FASTA_GB.v3.0.pl
# Autor: Luciano Kalabric
# Data YYYY-MM-DD: 2020-05-06
# Objetivo: Baixar sequencias de nucleotideos do Genbank no formato FASTA utilizando o módulo Bio::DB::GenBank BioPerl
# Sintaxe: perl baixa_FASTA_GB.v3.0.pl <Opções -id/av/qe/li> <Query id# ou acc# ou acc.version# ou "query string" ou acclist_filename> <redirect type> <output_filename>
# Exemplo: 

# Define path de entrada e saída de dados
# Para Windows						# Caminho padrão de dados de entrada e saída
# my $input_path = 'data\';			# Substituir por outro caminho de entrada
# my $output_path = $input_path;	# Substituir por outro caminho de saída
# my $path_separator = "\";

# Para Unix/Linux					# Caminho padrão de dados de entrada e saída
my $input_path = '../data/HEV';			# Substituir por outro caminho de entrada
my $output_path = $input_path;		# Substituir por outro caminho de saída
my $path_separator = "/";
my $acclist_filename;

# Valida os argumentos
my $command = "cat ~/cbperl/doc/baixa_FASTA_GB.v3.0.txt";
(scalar ( @ARGV ) >= 1) or die system ($command);

my ($opcao, $query_string, $redirect_type, $output_filename) = @ARGV;
($opcao eq "-id" or $opcao eq "-av" or $opcao eq "-qe" or $opcao eq "-li") or die "$opcao: Invalid option\n";
($redirect_type eq "add" or $redirect_type eq "app") or die "$redirect_type: Invalid redirection type or missing\n";

# Se não informado, define os nomes dos arquivos de entrada e saída padrões
if ($opcao eq "-li") {
	$acclist_filename = $query_string;
}
defined ($acclist_filename) or $acclist_filename = "acclist.txt";
defined ($redirect_type) or $redirect_type = ">";
if ( $redirect_type eq "app") { 
	$redirect_type = ">>";
} elsif ( $redirect_type eq "add" ) {
	$redirect_type = ">";
}	
defined ($output_filename) or $output_filename = "sequences.fasta";	

# Define o nome completo dos arquivos de entrada e saída com o path (somente Linux)
my $acclist_fullname = $input_path . $path_separator . $acclist_filename;
my $output_fullname = $output_path . $path_separator . $output_filename;

# Cria o filehandle OUTPUTHANDLE para escrever o arquivo de saída
open (OUTPUTHANDLE,$redirect_type,$output_fullname) or die "Não foi possível abrir o arquivo ",$output_filename,"\n\n";
# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele	

# Uso do módulo Bio::DB::Genbank do BioPerl
my $db = Bio::DB::GenBank->new();
# Objeto Bio::Seq para baixar sequencias do Genbank 
my $seqobj;

UNIQUE_ID:					
# Busca, baixa e salva sequencias por ID#, acc# e acc#.version#
# Desvia em caso de busca por query ou lista de acesso
if ( $opcao eq "-id" ) {							
	print "Downloading sequence by Unique ID# ",$query_string,"... ";
	$seqobj = $db->get_Seq_by_id($query_string);									# Objeto Seq para baixar por Unique ID
	print "completed!\n";
	print OUTPUTHANDLE ">","$seqobj->primary_id()","\n";							# Escreve o label
	print OUTPUTHANDLE $seqobj->seq(),"\n";											# Escreve a sequencia
} elsif ( $opcao eq "-av" ) {
	if ( $query_string !~ /./ ) {
		print "Downloading sequence by accession# ",$query_string,"... ";
		$seqobj = $db->get_Seq_by_acc($query_string);								# Objeto Seq para baixar por Accession Number
		print "completed!\n";
		print OUTPUTHANDLE ">",$seqobj->accession_number(),"\n";					# Escreve o label
		print OUTPUTHANDLE $seqobj->seq(),"\n";										# Escreve a sequencia
	} else {
		print "Downloading sequence by accession.version# ",$query_string,"... ";
		$seqobj = $db->get_Seq_by_version($query_string);							# Objeto Seq para baixar por Accession.version
		print "completed!\n";
		print OUTPUTHANDLE ">",$seqobj->accession_number(),".",$seqobj->version,"\n";	# Escreve o label
		print OUTPUTHANDLE $seqobj->seq(),"\n";											# Escreve a sequencia
	} 
} elsif ( $opcao eq "-qe" ) {
	goto QUERY;
} elsif ( $opcao eq "-li" ) {
	goto ACCLIST;
}
close OUTPUTHANDLE;
exit;

QUERY:
# Cria o filehandle OUTPUTHANDLE para escrever o arquivo de saída
open (OUTPUTHANDLE,$redirect_type,$output_fullname) or die "Can´t open file '$output_filename'!\n";
# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele	

# Objeto para baixar sequencias do Genbank 
my $query = Bio::DB::Query::GenBank->new
    (-query   =>$query_string,
     -db      => 'nucleotide');
my $seqio = $db->get_Stream_by_query( $query ); 
while( $seqobj = $seqio->next_seq ) {
	print "Downloading sequence accession.version# ",$seqobj->accession_number(),".",$seqobj->version(),"... ";
		
	# Output para a tela para acompanhamento do processo
	print " completed!\n";
	
	# Output para o arquivo de saída
	print OUTPUTHANDLE ">",$seqobj->accession_number(),".",$seqobj->version(),"\n";		# Escreve o label
	print OUTPUTHANDLE $seqobj->seq(),"\n\n";										# Escreve a sequencia
}
close OUTPUTHANDLE;
exit;

ACCLIST:
# Cria o filehandle INPUTHANDLE, abre/fecha o arquivo e armazena cada acc no array 
open (INPUTHANDLE, "<", $acclist_fullname) or die "Can't open file ",$acclist_fullname,"!\n";
# Output para um arquivo
open (OUTPUTHANDLE,$redirect_type,$output_fullname) or die "Can´t open file ",$output_filename,"!\n";
# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele	

while ( <INPUTHANDLE> ) {
	next if /^$/;    # Blank lines
    next if /^\s+$/; # Lines with only space chars
    next if /^\s*#/; # Just comments
	s/(.*)#.*/$1/;   # Cut comments after the data, if they are in the same line. 
	chomp;
	
	# Output para a tela para acompanhamento do processo
	print "Downloading sequence accession.version# ",$_,"... ";
	# Objeto Seq para baixar por Accession Number
	$seqobj = $db->get_Seq_by_acc($_);
	print "completed!\n";
	
	# Output para o arquivo de saída
	print OUTPUTHANDLE ">",$seqobj->accession_number,".",$seqobj->version,"\n";	# Escreve o label
	print OUTPUTHANDLE $seqobj->seq,"\n\n";										# Escreve a sequencia
}
close INPUTHANDLE;
close OUTPUTHANDLE;
exit;
