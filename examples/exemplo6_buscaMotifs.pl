#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo6_buscaMotifs.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Lê um motif do teclado e busca numa sequencia de DNA de um arquivo
# a) Operador <filehandle>
# a) Comandos open e close
# b) Operador busca /../
# c) Condicional if
# d) Função uc "uppercase"
# Sintaxe: perl exemplo6_buscaMotifs.pl

# Entra um motif do teclado
print "Entre um motif para busca:\n";
my $motif = uc(<STDIN>); 	# Converte <STDIN> em maiusculas
chomp $motif;				# Remore \n de $motif

# Armazena o nome do arquivo de entrada de dados
my $seq_filename = "input_sequencias.txt";

# Associa o nome do arquivo ao filehandle DNAFILE e abre o arquivo
open (DNAFILE, $seq_filename);

# Lê todas as linhas do arquivo em uma variavel array
my @seq = <DNAFILE>;

# Fecha o arquivo
close (DNAFILE);

# Une as linhas em uma variável escalar
my $seq = join ("",@seq);

# Remove \n
$seq =~ s/\n//g;

print "Eis a sequencia lida: $seq\n\n";

# Busca por um motif
if ($seq =~ /$motif/) {
	print "O motif $motif foi encontrado!\n";
	} else {
	print "O motif $motif não encontrado!\n";
}

# Finaliza o programa
exit;