#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemploXX_mapaderestricao.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Busca os sitios de uma enzima de restrição na sequencia no DNA e imprime o mapa de restrição
# Sintaxe: perl exemploXX_mapaderestricao.v1.0.pl

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

# Pega do usuário o nome da enzima para fazer o mapa de restrição
do { 
	print "Entre o nome da enzima (ou Enter para sair):\n";
	$query = <STDIN>;
	chomp $query;
	# Valida a entrada, se vazio saiu do programa
	if ($query =~ /^\s*$/) {
		exit;
	}
	if (exists $rebase_hash{$query}) {
		($sitio, $expressao_regular) = split (" ",$rebase_hash{$query});
		# Cria o mapa de restricao
		@posicoes = localiza_sitio ($expressao_regular, $dna);
		# Imprime o mapa de restricao
		if (@posicoes) {
			print "Procurando $query $rebase_hash{$query}...\n";
			print "Sitios para $query foram localizadas em:\n";
			print join (" ",@posicoes),"\n\n";
		} else {
			print "O sitio de restrição $expressao_regular da enzima $query não foi encontrado no DNA:\n";
			print "$dna\n\n";
		}
	} else {
		print "Enzima não cadastada em Rebase\n\n";
	}
} until ($query =~ /^\s*$/);

# Fim do programa
exit;

#
# Subrotinas
#

# Extrai os dados do arquivo Rebase bionet.txt
sub parse_Rebase {
	# Recebe o nome do arquivo Rebase como argumento da Subrotina
	my ($nomearquivoRebase) = @_;
	# Declara variaveis
	my @campos;
	my $nome;
	my $sitio;
	my $expressao_regular;
	my %rebase_hash;
	#  Lê o arquivo e retorna os dados Rebase
	unless (open(FILEHANDLE, "< $nomearquivoRebase")) {
		print "Arquivo $nomearquivoRebase não pode ser aberto!\n";
	exit;
	}
	while (<FILEHANDLE>) {
		# Descarta o cabeçalho do arquivo Rebase
		(1 .. /Rich Roberts/) and next;
		# Descarta linhas em branco
		(/^\s*$/) and next;
		# Separa os dados em campos (nome, alias, sitio de reconhecimento da enzima)
		@campos = split (" ",$_);
		# Armazena apenas o nome e o sitio
		$nome = shift @campos;
		$sitio = pop @campos;
		# Traduz os códigos ambiguos IUB para uma expressão regular
		$expressao_regular = IUB2regexp ($sitio);
		# Cria uma variavel hash que armazena todos os nome, sitios e expressoes regulares da enzimas de restricao
		$rebase_hash{$nome} = "$sitio $expressao_regular";
	}
	return %rebase_hash;
}

# Traduz os códigos ambiguos IUB para uma expressão regular
sub IUB2regexp {
	# IUB2regexp
	#
	# A subroutine that, given a sequence with IUB ambiguity codes,
	# outputs a translation with IUB codes changed to regular expressions
	#
	# These are the IUB ambiguity codes
	# (Eur. J. Biochem. 150: 1-5, 1985):
	# R = G or A
	# Y = C or T
	# M = A or C
	# K = G or T
	# S = G or C
	# W = A or T
	# B = not A (C or G or T)
	# D = not C (A or G or T)
	# H = not G (A or C or T)
	# V = not T (A or C or G)
	# N = A or C or G or T
	my ($iub) = @_;
	my $expressao_regular = "";
	my %iub2character_class = (
		A => 'A',
		C => 'C',
		G => 'G',
		T => 'T',
		R => '[GA]',
		Y => '[CT]',
		M => '[AC]',
		K => '[GT]',
		S => '[GC]',
		W => '[AT]',
		B => '[CGT]',
		D => '[AGT]',
		H => '[ACT]',
		V => '[ACG]',
		N => '[ACGT]',
	);
	# Remove the ^ signs from the recognition sites
	$iub =~ s/\^//g;
	# Traduz cada caracter IUB do sitio
	for ( my $i = 0 ; $i < length($iub) ; ++$i ) {
		$expressao_regular.= $iub2character_class{substr($iub, $i, 1)};
	}
	return $expressao_regular;
}

# Localiza os sitio de uma enzima no DNA
sub localiza_sitio {
	my ($expressao_regular, $sequencia) = @_;
	my @posicoes;
	while ($sequencia =~ /$expressao_regular/ig) {
		# Adiciona a posição encontrada no final do array @posicoes
		push (@posicoes, pos ($sequencia) - length ($&) + 1);
	}
	return @posicoes;
}