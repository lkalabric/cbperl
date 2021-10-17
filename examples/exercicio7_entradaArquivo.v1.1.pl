#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio7_entradaArquivo.v1.1.pl
# Autor: Luciano Kalabric
# Data: 2014-05-02
# Uso: Lê as proteínas do arquivo multiplo de sequencias "input_Proteinas.txt" e imprime os resultados
# a) Uso do comando open
# b) Uso do operador <filehandle>
# Sintaxe: perl exercicio7_entraArquivo.v1.1.pl

# Armazena o nome do arquivo de entrada de dados
my $protein_filename = "input_Proteinas.txt";

# Associa o nome do arquivo ao filehandle PROTEINFILE e abre o arquivo
open (PROTEINFILE, $protein_filename);

# Feito isso, vamos fazer a leitura verdadeiramente da proteina do arquivo
my $proteina = <PROTEINFILE>;
# Imprime a primeira proteína
print "Aqui está a primeira proteína lida:\n";
print "$proteina\n\n";

$proteina = <PROTEINFILE>;
# Imprime a segunda proteína
print "Aqui está a segunda proteína lida:\n";
print "$proteina\n\n";

$proteina = <PROTEINFILE>;
# Imprime a terceira proteína
print "Aqui está a terceira proteína lida:\n";
print "$proteina\n\n";

# Agora que já lemos  a proteina, vamos fechar o arquivo
close (PROTEINFILE);

# Finaliza o programa
exit;