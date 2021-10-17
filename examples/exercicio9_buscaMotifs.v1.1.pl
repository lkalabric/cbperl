#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio9_buscaMotifs.v1.1.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Busca motifs em arquivos sequencias e gera estatistica do numero de matches
# a) Uso função open
# b) Uso do operador <filehandle>
# c) Uso do comendo unless para condicional e controle de loop
# d) Uso do comando while para condicional e controle de loop
# e) Uso do operador busca ~//
# Sintaxe: perl exercicio9_buscaMotifs.v1.1.pl

# Armazena o nome do arquivo de entrada de dados
my $motifs_filename = "input_motifs.txt";
my $sequencias_filename = "input_sequencias.txt";

# Gera mensagem de erro se não puder abrir o arquivo motifs.txt
unless (open(HANDLEFILE1,$motifs_filename)) {
	print "Arquivo $motifs_filename não encontrado!!!\n";
	exit;
} 

# Gera mensagem de erro se não puder abrir o arquivo sequencias.txt
unless (open(HANDLEFILE2,$sequencias_filename)) {
	print "Arquivo $sequencias_filename não encontrado!!!\n";
	exit;
}

# Abre os arquivos de entrada de dados
# open (HANDLEFILE1, $motifs_filename);

# Busca cada motif em todas as sequencias e gera uma estatística
while (my $motif = <HANDLEFILE1>) {
	chomp $motif; 			# Remove a quebra de linha do motif
	my $i = 0; 				# Contador de matchs do motif
	my $j = 0;				# Contador de sequencias
	open (HANDLEFILE2, $sequencias_filename);
	while (my $sequencia = <HANDLEFILE2>) {
		chomp $sequencia; 	# Remove a quebra de linha da sequencia
		$j++;			
		if ($sequencia =~ /$motif/) {
			$i++;
		}
	}
	print "O motif $motif foi encontrado em $i das $j sequencias.\n";
	close (HANDLEFILE2);
}

# Fecha os arquivos de entrada
close (HANDLEFILE1);

# Finaliza o programa
exit;