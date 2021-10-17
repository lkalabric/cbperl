#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio9_buscaMotifs.v1.2.pl
# Autor: Luciano Kalabric
# Data: 2014-05-02
# Uso: Busca motifs em arquivos sequencias e gera estatistica do numero de matches
# Sintaxe: perl exercicio9_buscaMotifs.v1.2.pl input_motifs.txt input_sequencias.txt
# a) Uso função open
# b) Uso do operador <filehandle>
# c) Uso do comando unless para condicional e controle de loop
# d) Uso do comando while para condicional e controle de loop
# e) Uso do operador busca ~//

# Armazena o nome do arquivo de entrada de dados
unless (scalar @ARGV ==2) {
	print "Número de parâmatros insuficientes!\n\n";
	print "Sintaxe: perl exercicio9_buscaMotifs.v1.2.pl input_motifs.txt input_sequencias.txt\n";
	exit;
}	

my $motifs_filename = $ARGV[0];
my $sequencias_filename = $ARGV[1];

# Gera mensagem de erro se não puder abrir o arquivo motifs.txt
unless (open(HANDLEFILE1,$motifs_filename)) {
	print "Arquivo motifs.txt não encontrado!!!\n";
	exit;
} 

# Gera mensagem de erro se não puder abrir o arquivo sequencias.txt
unless (open(HANDLEFILE2,$sequencias_filename)) {
	print "Arquivo sequencias.txt não encontrado!!!\n";
	exit;
}

# Abre os arquivos de entrada de dados
open (HANDLEFILE1, $motifs_filename);

# Busca cada motif em todas as sequencias e gera uma estatística
while (my $motif = <HANDLEFILE1>) {
	chomp $motif; 			# Remove a quebra de linha do motif
	my $i = 0; 				# Contador de matches do motif
	my $j = 0; 				# Contador de sequencias
	open (HANDLEFILE2, $sequencias_filename);
	while (my $sequencia = <HANDLEFILE2>) {
		chomp $sequencia; 	# Remove a quebra de linha da sequencia
		$j += 1;
		if ($sequencia =~ /$motif/) {
			$i += 1;
		}
	}
	close (HANDLEFILE2);
	print "O motif $motif foi encontrado em $i das $j sequencias.\n";
}

# Fecha os arquivos de entrada
close (HANDLEFILE1);

# Finaliza o programa
exit;