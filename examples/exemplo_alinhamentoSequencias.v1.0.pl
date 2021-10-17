#!/usr/bin/perl
use strict;
use warnings;
use String::Alignment;
use String::Alignment qw(do_alignment);

# Programa: exemplo_comandoPrint.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-05-01
# Uso: Aprender a alinhar sequencias
# a) Uso do módulo String-alignment

# Sequencias a serem alinhadas
my $s1 = "ATGTCGTAGTGCTTATAGATACGCTA";
print "Sequencia 1: $s1\n";

my $s2 = "ATTCGTAGCGCTTTTAGATACGCTA";
print "Sequencia 2: $s2\n";

# local alignment
my $result = do_alignment($s1,$s2,1); 
print "Resultado do alinhamento local: $result\n";

# global alignment
my $result = do_alignment($s1,$s2); 
print "Resultado do alinhamento global: $result\n";

exit;