#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio7_entradaArquivo.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Lê uma proteína do arquivo multiplo de sequencias "input_Proteinas.txt" e imprime o resultado
# a) Uso do comando open
# b) Uso do operador <filehandle>
# Sintaxe: perl exercicio7_entraArquivo.v1.0.pl

# Armazena o nome do arquivo de entrada de dados
# my $protein_filename = "input_Proteinas.txt";

# Associa o nome do arquivo ao filehandle PROTEINFILE e abre o arquivo
open (PROTEINFILE, "< input_Proteinas.txt");
# Pode ser simplificado para open (PROTEINFILE,$protein_filename);

# Feito isso, vamos fazer a leitura verdadeiramente da proteina do arquivo
my $proteina = <PROTEINFILE>;

# Agora que já lemos  a proteina, vamos fechar o arquivo
close (PROTEINFILE);

# Imprime a proteína
print "Aqui está a proteína lida:\n";
print "$proteina\n\n";

# Finaliza o programa
exit;