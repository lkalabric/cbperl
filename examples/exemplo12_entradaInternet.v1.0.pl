#!/usr/bin/perl -w
use strict;
use warnings;
use LWP::Simple;

# Programa: exemplo12_entradaInternet.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-08-06
# Uso: Baixar uma sequencia de DNA no formato Fasta, diretamente do NCBI, a partir do seu numero de acesso.
# a) Instalacao de modulo;
# b) Uso dos e-Utilities do NCBI;
# c) Uso do modulo LWP::Simple;
#
# Referências:
# Bessant, C.; Shadforth, I.; Oakley, D. Building bioinformatics solutions: with
# Perl, R and MySQL. Oxforf University Press, New York, 1 edition, Nov. 2008.
#
# Sayers, E.; Wheeler, D. Building customized data pipelines using the Entrez
# Programming Utilities (eUtils). http://www.ncbi.nlm.nih.gov/bookshelf/br.fcgi?book=coursework&part=eutils
#

system ( "cls" );

# Dados do URL do E-utilities
my $utils = 'http://www.ncbi.nlm.nih.gov/entrez/eutils/';
my $dbase = 'nucleotide';
my $reply = 'fasta';
my $accession = "D11168.1";
my $query = $utils . "efetch.fcgi?db=" . $dbase . "&id=" . $accession . "&rettype=" . $reply;

# Executa a subrotina get do módulo LWP::Simple
my $fasta = get ( $query );
print "$fasta\n";

# Executa a subrotina getprint do módulo LWP::Simple
getprint ( $query ); 	# Busca ao registro no formato FASTA e ja faz a impressao
						# do mesmo sem utilizar uma variavel para armazenar o
						# conteudo.

# Finaliza o programa
exit;
