#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio7_entradaArquivo.v1.2.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Lê as proteínas do arquivo multiplo de sequencias "input_Proteinas.txt" e imprime os resultados
# a) Uso do comando open
# b) Uso do operador <filehandle>
# c) Uso da função join
# Sintaxe: perl exercicio7_entradaArquivo.v1.2.pl

# Armazena o nome do arquivo de entrada de dados
my $protein_filename = "input_Proteinas.txt";

# Associa o nome do arquivo ao filehandle PROTEINFILE e abre o arquivo
open (PROTEINFILE, $protein_filename);

# Feito isso, vamos fazer a leitura verdadeiramente da proteina do arquivo
my @proteina = <PROTEINFILE>;
	
# Agora que já lemos  a proteina, vamos fechar o arquivo
close (PROTEINFILE);

# Imprime as sequencias separadamente
print "Aqui está(ão) a(s) proteína(s) lida(s):\n";
print @proteina,"\n\n";

# Concatena as sequencias em uma só
chomp $proteina[0];	# Remove o \n de cada sequencia lida
chomp $proteina[1];
chomp $proteina[2];
my $proteina = join ("",@proteina);

# Imprime a sequencia da proteina concatenada
print "Aqui está(ão) a(s) proteína(s) concatenadas:\n";
print $proteina;

# Finaliza o programa
exit;