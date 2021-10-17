#!/usr/bin/perl -w

# exemplo7_mgetFASTA.pl
#
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
# a) Ler registros de um arquivo;
# b) Gravar registros em um arquivo;
# c) Passar parametros na chamada do programa;
# d) Validar os parametros na chamada do programa;

use strict;
use warnings;

use LWP::Simple;

my $fasta = "";
my $query = "";

my $utils = 'http://www.ncbi.nlm.nih.gov/entrez/eutils/';
my $dbase = 'nucleotide';
my $reply = 'fasta';

system ( "cls" );

scalar ( @ARGV ) == 2 or die "\nNumber of parameters must be 2.\n\n\$ perl program_name input_file_name output_file_name\n\n";

open F_INP, "<", $ARGV[0] or die "Can't open file '$ARGV[0]': $!";
open F_OUT, ">", $ARGV[1] or die "Can't open file '$ARGV[1]': $!"; 

while ( <F_INP> ) {
        next if /^$/;    # Blank lines
        next if /^\s+$/; # Lines with only space chars
        next if /^\s*#/; # Just comments
    
        s/(.*)#.*/$1/;   # Cut comments after the data, if they are in the same line. 
    
        chomp;
        
        $query = $utils . "efetch.fcgi?db=" . $dbase . "&id=" . $_ . "&rettype=" . $reply;
        
        $fasta = get ( $query );
        
        chomp ( $fasta );
        
        print F_OUT "$fasta\n";
        
        print "\n$query... done!\n";
}

close F_INP;
close F_OUT;

exit;
