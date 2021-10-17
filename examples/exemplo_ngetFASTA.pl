#!/usr/bin/perl -w

# exemplo8_ngetFASTA.pl
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
# a) Uso do operador diamante;
# b) Redirecionamento de entrada e saída de dados na chamada do programa;

use strict;
use warnings;

use LWP::Simple;

my $fasta = "";
my $query = "";

my $utils = 'http://www.ncbi.nlm.nih.gov/entrez/eutils/';
my $dbase = 'nucleotide';
my $reply = 'fasta';

# system ( "clear" );

while ( <> ) {
        next if /^$/;    # Blank lines
        next if /^\s+$/; # Lines with only spaces chars
        next if /^\s*#/; # Just comments
    
        s/(.*)#.*/$1/;   # Cut comments after the data, if there are in the same line. 
    
        chomp;
        
        $query = $utils . "efetch.fcgi?db=" . $dbase . "&id=" . $_ . "&rettype=" . $reply;
        
        $fasta = get ( $query );
        
        chomp ( $fasta );
        
        print "$fasta\n";
}

exit;
