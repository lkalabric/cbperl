#!/usr/bin/perl
use strict;
use warnings;
use CBPerl;

# Programa: exemploXX_mapaderestricao.v1.1.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Busca os sitios de uma enzima de restrição na sequencia no DNA e imprime o mapa de restrição
# Sintaxe: perl exemploXX_mapaderestricao.v1.1.pl

# Declara as variáveis
my $dna = "ATGAATTCCATAGCCATGGAATTCTCATGCATTTTAGTATAGGATCATCATATGCATCATGATACATCATAGGAATTCATATGGGACCACA";
my $nomearquivoRebase = "bionet.txt";
my @posicoes;
my $nome;
my $query;
my $expressao_regular;
my $sitio;

# Extrai os dados do arquivo Rebase bionet.txt e cria expressoes regulares a partir dos sitio de reconhecimento das enzimas
my %rebase_hash = parse_Rebase ($nomearquivoRebase);
sort keys %rebase_hash;

# Procura por todos os sitios das enzimas do arquivo Rebase bionet.txt e imprime o mapa de restrição
my $enzima;
foreach $enzima (sort keys %rebase_hash) {
    ($sitio, $expressao_regular) = split (" ",$rebase_hash{$enzima});
	# Cria o mapa de restricao
	print "Procurando por $enzima $sitio...\n";
	@posicoes = busca_Motif ($dna, $expressao_regular);
	# Imprime o mapa de restricao
	if (@posicoes) {
		print "Sitios para $enzima foram localizadas em:\n";
		print join (" ",@posicoes),"\n\n";
	} else {
		print "Não há sitios para $enzima no DNA\n\n";
	}
}

# Fim do programa
exit;
