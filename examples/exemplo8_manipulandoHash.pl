#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo8_manipulandoHash.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Aprender algumas manipulações de hash
# Sintaxe: perl exemplo8_manipulandoHash.pl

# Define uma variável tipo Hash
my %nt_names = ("A","adenosina","T","timidina","C","citidina","G","guanosina");
my %base_names = (A=>"adenina",T=>"timina",C=>"citosina",G=>"guanina");	# => torna mais fácil entender 

# Obtem os índices ou chaves de uma variável hash
my @iupac_code = keys %nt_names;		# a função keys retorna os índices de uma variável hash
print "@iupac_code\n";

# Obtem os valores de uma variável hash
my @nt_names = values %nt_names;		# a função values retorna os valores de uma variável hash
print "@nt_names\n";

delete $base_names {A}; # Apaga o valor de chave "A"

if (exists $base_names {T}) { print "Achei a base T no hash\n"; } # Testa se um valor de chave "T" existe no hash

# Lista as chaves e valores de uma variável hash
foreach my $key (keys %base_names) {
	print "O nome da base $key é $base_names{$key}\n";
}