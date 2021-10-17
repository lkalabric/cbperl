#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo4_controleFluxo.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Aprender sobre estruturas de controle de fluxo condicionais e loops
# a) Uso if
# b) Uso if() - else
# c) Uso if() elsif() - else
# d) Uso unless()
# e) Uso while()
# f) Uso do {..} until()
# g) Uso for
# h) Uso foreach
# i) Uso or die
# j) Uso do operador busca /../ e de expressões regulares
# Sintaxe: perl exemplo4_controleFluxo.pl

my $dna = "ATCTGTGACTTAAA";
my $rna = "AUCUGUGACUUAAA";
my $seq;

system ('cls');						# Executa o comando cls (clear screen) no cmd do Windows
									# system ('clear') no bash do Linux

# Converto o escalar em array
my @dna = split ("",$dna);
my @rna = split ("",$rna);

# Calcula o número de bases da sequenca
my $tam_dna = @dna;
my $tam_rna = @rna;

# If(), If()-else, If()-elsif-else
if ($tam_dna == $tam_rna) {
	print "O DNA tem o mesmo tamanho que o RNA!\n\n";
}

if ($dna =~ /T/) {
	print "O dado armazenado em \$dna é uma sequencia de DNA!\n\n";
} else {
	print "O dado armazenado em \$dna pode não ser uma sequencia de DNA!\n\n";
}
	
if ($rna =~ /T/) {
	print "O dado armazenado em \$rna é uma sequencia de DNA!\n\n";
} elsif ($rna =~ /U/){
	print "O dado armazenado em \$rna é uma sequencia de RNA!\n\n";
} else {
	print "O dado armazenado em \$rna não parece ser uma sequencia de DNA ou RNA!\n\n";
}

# Unless()
my $filename = "input_sequencias.txt";
unless (-e $filename) {								# Verifica se o arquivo existe -e
	print "Arquivo \"$filename\" parece não existir!\n";
}

unless (open (DNAFILE,$filename)) { 				# Neste contexto, se o arquivo existe, abre o arquivo. 
	print "Não foi possível abrir este arquivo!\n";	# Caso contrário, imprime a mensagem de erro
	exit;											# Sai do programa
}
print "Arquivo aberto com sucesso!\n\n";

my($arg1, $arg2) = @ARGV;
unless ($arg2) {
	print "O argumento \$arg2 não foi passado para o programa!\n\n";
}

# While
while (<DNAFILE>) { 					
	print "Esta é uma linha do arquivo: $_";	# $_ é a variavel especial padrão 	
	(/^\s*$/) and next;							# Pula se linha em branco
}
close DNAFILE; # Fecha o arquivo

# Do {..} until ()
do {
	print "\n\nEntre uma sequencia <vazio para sair>:";
	$seq = <STDIN>;
	chomp $seq; 									# Remove o "\n" do fim de $seq
	if ($seq =~ /T|t/) {
		print "Pode ser uma sequencia de DNA!\n";
	} elsif ($seq =~ /U|u/) {
		print "Pode ser uma sequencia de RNA!\n";
	} else {
		print "Nao sei o que é!!!\n";
	};
} until ($seq =~ /^\s*$/);							# Sai se a entrada é vazia!

# For
my $max = $tam_dna;									# Variavel que define o numero maximo de loops
my @bases = split("",$dna);
print "pos - base\n";
for(my $i=0; $i<=$max-1; $i++){      				# Forma completa para loops regulares ou irregulares
	print $i+1," - ",$bases[$i],"\n"; 				
}

for(0..$max){                   					# Forma simplificada para loops regulares apenas
	print "$_\n";									
}

# Foreach
my $num_A = 0;
my $num_T = 0;
my $num_C = 0;
my $num_G = 0;
foreach (@bases) {
	if ($_ eq "A") {
		$num_A++; 									# Contador do numero de As
	} elsif ($_ eq "T") {
		$num_T++; 									# Contador do numero de Ts
	} elsif ($_ eq "C") {
		$num_C++; 									# Contador do numero de Cs
	} elsif ($_ eq "G") {
		$num_G++; 									# Contador do numero de Gs
	}
}
print "A = $num_A; T = $num_T; C = $num_C; G = $num_G\n";


# Uso de "or die"
scalar ( @ARGV ) == 2 or die "\nNúmero de argumento deve ser 2.\n\n\$ perl exercicio4_concatenaSequencias.v1.1.pl seq1 seq2\n\n";

# Fim do programa
exit;