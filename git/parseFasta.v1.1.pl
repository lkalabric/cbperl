#!/usr/bin/perl
use strict;
use warnings;
use autodie;

use CBPerl;
use Bio::Perl;
use Bio::SeqFeatureI;
use Bio::SeqIO;		

# Programa: parseFasta.v1.1.pl
# Autor: Luciano Kalabric
# Data: 2018-02-02
# Uso: Analisa um arquivo Fasta com uma ou mais sequencias
# Sintaxe: parseFasta.v.1.0.pl <nome_arquivo_Fasta>

# Definição de variáveis e objetos utilizados pelo módulo Bio::DB::Genbank
my $seqio;	# Armazena a sequencia
my $seqobj;	# Armazena a sequencia
