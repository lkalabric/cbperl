#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo10_parseFasta.v1.2.pl
# Autor: Luciano Kalabric
# Data: 2014-05-02
# Uso: Extrai dados de um arquivo de sequencias multiplas Fasta
# a) Comando Open
# b) Operador <filehandle>
# c) Foreach
# d) For

my $input_filename = "input_multiseq_fastaFile.txt";
# armazena o nome do arquivo de entrada de dados

unless (open (INPUTHANDLE, "$input_filename")) {
	print "Arquivo não encontrado\n:";
	exit;
}

# associa o nome do arquivo ao filehandle
# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele

# Lê os dados do arquivo e armazena em uma variável array
my @multifasta = <INPUTHANDLE>;

close INPUTHANDLE;
# fecha o arquivo input_fasta.txt

my $num_seq = 0;
my @fasta;

# Lê os dados do arquivo, linha-por-linha e armazena o tag e seq em dois array diferentes
foreach (@multifasta) {
	if ($_ =~ />/) { # Se a linha contem > isto é um tag
		$fasta[$num_seq] = $_; # Armazena o tag apenas
		$num_seq++;
	} elsif ($_ eq "") { # Se a linha está em branco, pula para a próxima
		next;
	} else { # Se a linha não é um tag nem um 
		$fasta[$num_seq-1] .= $_;	# Armazena a seq apenas
	}
}

# Reune o tag e a sequencia e armazena em um elemento de um array
for(0..$num_seq-1) {
	print $fasta[$_],"\n";
}

# Fim do programa
exit;