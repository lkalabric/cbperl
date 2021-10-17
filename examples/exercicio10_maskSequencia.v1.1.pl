#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio10_maskSequencia.v1.1.pl
# Autor: Luciano Kalabric
# Data: 2014-08-06
# Uso: Aprender a criar subrotinas no Perl
# Sintaxe: perl exercicio10_maskSequencia.v1.1.pl input_primers.txt input_sequencias.txt
# a) Uso do comando or die
# a) Uso do comando open
# b) Uso do operador <filehandle>
# c) Uso do comando sub

# Verifica se 2 argumentos foram passados para o programa. Se negativo, imprime uma mensagem e encerra o programa 
scalar ( @ARGV ) == 2 or die "\nNúmero de argumento deve ser 2.\n\n\$ perl exercicio11_maskSequencia.v1.1.pl input_primers.txt input_sequencias.txt\n\n";

# Armazena os argumentos que correspondem aos nomes dos arquivos de entrada nas respectivas variáveis
my $primers_filename = $ARGV[0];
my $sequencias_filename = $ARGV[1];

# Gera mensagem de erro se não abre o arquivo input_primers.txt
unless (open(FILEHANDLE1,$primers_filename)) {
	print "Arquivo input_primers.txt não encontrado!!!\n";
	exit;
} 

# Gera mensagem de erro se não abre o arquivo sequencias.txt
unless (open(FILEHANDLE2,$sequencias_filename)) {
	print "Arquivo input_sequencias.txt não encontrado!!!\n";
	exit;
}

# Abre os arquivos de entrada de dados e transfere seu conteúdo para as listas @primer e @sequencia
open (FILEHANDLE1, $primers_filename);
my @primer = <FILEHANDLE1>; # Lê os primers
close FILEHANDLE1;

open (FILEHANDLE2, $sequencias_filename);
my @sequencia = <FILEHANDLE2>;
my $sequencia = join ("",@sequencia); # Concatena todas as sequencias do arquivo no escalar $sequencia
$sequencia =~ s/\s//g; # Remove os espaços em branco da sequencia concatenada
$sequencia =~ s/\n//g; # Remove os \n da sequencia concatenada
close FILEHANDLE2;

# Declara as variáveis usadas dentro do loop for
my $revcompl;
my $primer;	
my $masked_seq = $sequencia;

# Busca cada primer na sequencia e faz o mask
foreach (@primer){     
	chomp $_;
	$primer = $_;
	$revcompl = rev_Complemento ($primer); 	# Determina o reverso complemento do primer
	$primer = IUB2regexp ($primer);			# Converte os códigos IUPAC para expressão regular
	$revcompl = IUB2regexp ($revcompl);
	if ($masked_seq =~ /$primer/) {
		print "Primer $primer encontrado na sequencia\n\n";
		$masked_seq = mask_Sequencia ($primer,$masked_seq); # Mascara o primer na sequencia
	} elsif ($masked_seq =~ /$revcompl/) {
		print "O rev. complemento do primer $primer foi encontrado na sequencia\n\n";
		$masked_seq = mask_Sequencia ($revcompl,$masked_seq); # Mascara o primer na sequencia
	} else {
		print "Primer $primer não encontrado!\n\n";
	}
}

# Apresenta o resultado
print "Sequencia: $sequencia\n\n";
print "Sequencia mascarada: $masked_seq\n\n";

# Finaliza o programa
exit;

# Subrotinas
# Faz o reverso complemento para busca dos primers antisense na sequencia principal
sub rev_Complemento {
	my $rc = reverse @_;
	$rc =~ tr/ATCGRYMKBD/TAGCYRKMVH/;
	return $rc;
}

# Mascara o primer na sequencia
sub mask_Sequencia {
	my ($expressao_regular, $masked_seq) = @_;
	my $tam_seq = $expressao_regular; 	# Calcula o tamanho da sequencia codificada pela expressao regular
	$tam_seq =~ s/\[\w{2,4}\]/X/g; 		# Substitui a expressao regular por X 
	my $mask = "X" x length $tam_seq; 	# Cria a máscara com o tamanho da sequencia
	
	# Substitui o sequencia pela máscada
	$masked_seq =~ s/$expressao_regular/$mask/g;
	return $masked_seq;
}

# Traduz códigos ambiguos IUB em uma expressão regular
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
	# U = N (desoxiuracil)
	# I = N (desoxiinosina)
	# F = A-fosfotiato (A or T)
	# O = C-fosfotiato (C or G)
	# E = G-fosfotiato (T or G)
	# Z = T-fosfotiato (A or C)
	# . or - = gap
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
		B => '[CGT]',
		D => '[AGT]',
		H => '[ACT]',
		V => '[ACG]',
		N => '[ACGT]',
		X => '[ACGT]',
		I => '[ACGT]'
	);
	# Remove o sinal ^ (sitio de uma enzima), se presente
	$iub =~ s/\^//g;
	
	# Remove o sinal * (nucleotideos especiais), se presente
	$iub =~ s/\*//g;
	
	# Remove o sinal . ou - (gap), se presente
	$iub =~ s/\.//g; $iub =~ s/\-//g;
	
	
	# Traduz cada caracter IUB do sitio
	for ( my $i = 0 ; $i < length($iub) ; ++$i ) {
		$expressao_regular.= $iub2character_class{substr($iub, $i, 1)};
	}
	return $expressao_regular;
}
