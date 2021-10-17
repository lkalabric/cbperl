#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo8_manipulandoHash.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Aprender algumas manipula��es de hash
# Sintaxe: perl exemplo8_manipulandoHash.pl

# Define uma vari�vel tipo Hash
my %nt_names = ("A","adenosina","T","timidina","C","citidina","G","guanosina");
my %base_names = (A=>"adenina",T=>"timina",C=>"citosina",G=>"guanina");	# => torna mais f�cil entender 

# Obtem os �ndices ou chaves de uma vari�vel hash
my @iupac_code = keys %nt_names;		# a fun��o keys retorna os �ndices de uma vari�vel hash
print "@iupac_code\n";

# Obtem os valores de uma vari�vel hash
my @nt_names = values %nt_names;		# a fun��o values retorna os valores de uma vari�vel hash
print "@nt_names\n";

delete $base_names {A}; # Apaga o valor de chave "A"

if (exists $base_names {T}) { print "Achei a base T no hash\n"; } # Testa se um valor de chave "T" existe no hash

# Lista as chaves e valores de uma vari�vel hash
foreach my $key (keys %base_names) {
	print "O nome da base $key � $base_names{$key}\n";
}