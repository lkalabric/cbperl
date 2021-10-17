#!/usr/bin/perl -w

# exemplo6_getFASTA.pl
#
# Obter informacoes de uma sequencia em formato FASTA, diretamente do NCBI, a 
# partir do seu numero de acesso.
#
# Referências:
# Bessant, C.; Shadforth, I.; Oakley, D. Building bioinformatics solutions: with
# Perl, R and MySQL. Oxforf University Press, New York, 1 edition, Nov. 2008.
#
# Sayers, E.; Wheeler, D. Building customized data pipelines using the Entrez
# Programming Utilities (eUtils). http://www.ncbi.nlm.nih.gov/bookshelf/br.fcgi?book=coursework&part=eutils
#
# a) Instalacao de modulo;
# b) Uso dos e-Utilities do NCBI;
# c) Uso do modulo LWP::Simple;

# O modulo LWP::Simple deve ser instalado com o comando a seguir executado em um
# terminal (Linux ou Mac OS). Lembre-se de SEMPRE instalar modulos como "root",
# p. ex., usando "sudo":
# 
# sudo perl -MCPAN -e 'install LWP::Simple'
#
# LWP e' a biblioteca Perl para WWW (The World-Wide Web Library for Perl) e 
# LWP::Simple sao os procedimento da interface da LWP (Simple Procedural Interface
# to LWP);

use strict;
use warnings;

use LWP::Simple;

system ( "cls" );

my $utils = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
my $dbase = 'nucleotide';
my $reply = 'fasta&retmode=text';

my $an = "AU232460";

my $query = $utils . "efetch.fcgi?db=" . $dbase . "&id=" . $an . "&rettype=" . $reply;
print $query,"n";

my $fasta = get ( $query );
print "\n";
print "$fasta\n";

getprint ( $query ); # tim-toady
                     # Busca ao registro no formato FASTA e ja faz a impressao
                     # do mesmo sem utilizar uma variavel para armazenar o
                     # conteudo.

exit;
