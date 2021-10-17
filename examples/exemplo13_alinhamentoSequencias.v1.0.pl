#!/usr/bin/perl
use strict;
use warnings;
use String::Alignment;
use String::Alignment qw(do_alignment);

# Programa: exemplo13_alinhamentoSequencias.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Aprender a alinhar sequencias
# a) Uso do módulo String-alignment

# Sequencias a serem alinhadas
my $s1 = "ATGTCGTAGTGCTTATAGATACGCTA";
print "Sequencia 1: $s1\n";

my $s2 = "ATTCGTAGCGCTTTTAGATACGCTA";
print "Sequencia 2: $s2\n";

# Local alignment
my $local = do_alignment($s1,$s2,1); 
print "Resultado do alinhamento local: $local\n";

# Global alignment
my $global = do_alignment($s1,$s2); 
print "Resultado do alinhamento global: $global\n";

# Finaliza o programa
exit;