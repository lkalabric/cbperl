#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo11_parseFasta.v1.1.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Extrai dados de um arquivo de sequencias multiplas Fasta
# a) Comando Open
# b) Operador <filehandle>
# c) While
# d) For
# Sintaxe: perl exemplo11_parseFasta.v1.1.pl

my $input_filename = "input_multiseq_fastaFile.txt";
# armazena o nome do arquivo de entrada de dados

unless (open (INPUTHANDLE, "$input_filename")) {
	print "Arquivo não encontrado\n:";
	exit;
}

# associa o nome do arquivo ao filehandle
# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele

my $num_seq = 0;
my $linha;
my @fasta_tag;
my @fasta_seq;

# Lê os dados do arquivo, linha-por-linha e armazena o tag e seq em dois array diferentes
while ($linha = <INPUTHANDLE>) {
	chomp $linha;
	if ($linha =~ /^\s*$/) {
		next;
	} elsif ($linha =~ />/) {
		$fasta_tag[$num_seq] = $linha;
		next;
	} else {
		do {
			chomp $linha;
			$fasta_seq[$num_seq] .= $linha;	
			$linha = <INPUTHANDLE>;
		} until (($linha =~ /^\s*$/) or ($linha =~ />/));
		$num_seq++;
	}
}

# Fecha o arquivo input_fasta.txt
close INPUTHANDLE;


# Reune o tag e a sequencia e armazena em um hash
my %sequencia;
for(0..$num_seq-1) {
	$sequencia{$fasta_tag[$_]} = $fasta_seq[$_];
}

# Lista as sequencias armazenadas no hash
foreach my $key (sort keys %sequencia) {
     print "$key: $sequencia{$key}\n";
}


# Fim do programa
exit;