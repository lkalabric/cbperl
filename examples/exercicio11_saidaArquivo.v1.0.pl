#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio10_saidaArquivo.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-05-02
# Uso: Aprender a escrever dados em um arquivo
# a) Uso do comando Open
# b) Uso do operador <filehandle>

my $output_filename = "output.txt";
# armazena o nome do arquivo de saída de dados

open (OUTPUTHANDLE, "> $output_filename");
# associa o nome do arquivo ao filehandle
# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele

print OUTPUTHANDLE "Resultados das analises\n";
# imprime o dado lido que corresponde à primeira linha do arquivo output.txt

close OUTPUTHANDLE ;
# fecha o arquivo output.txt
