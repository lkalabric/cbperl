#!/usr/bin/perl
use strict;
use warnings;
use CBPerl;

# Programa: exemplo11_parseFastafile.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Le um arquivo Fasta com sequencia unica
# Sintaxe: perl exemplo11_parseFastafile.v1.0.pl

# Chama a subrotina que lê os dados de um arquivo
my @dadosFasta = le_Arquivo("input_Fastafile.txt");

# Extrai o $header e a $sequencia do arquivo Fasta
my $header;
my $sequencia; 									
foreach my $linha (@dadosFasta) {
	# Remove a quebra de linha
	chomp $linha; 
	# Descata linha em branco
	if ($linha =~ /^\s*$/) {
		next;
	# Extrai o header da sequencia
	} elsif ($linha =~ /^>/) {
		$header = $linha;
		next;
	} else {
		$sequencia .= $linha;
	}
}
	
# Imprime o resultado
print $header,"\n";
print $sequencia,"\n";

# Finaliza o programa
exit;
