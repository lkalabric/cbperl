#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo_randomMutation.v1.1.pl
# Autor: Luciano Kalabric
# Data: 2014-08-12
# Uso: Gera mutações em sitios aleatórios de uma sequencia DNA
# a) Função int
# b) Função rand

# Declara e inicializa as variaveis globais
my $dna = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

# Antes de gerar números aleatórios deve-se iniciar o gerador de números
# srand(time|$$); # Forma mais popular que combina o tempo atual com o id do programa

# Chama a rotina mutate
my $mutant = mutate($dna);


# Imprime os resultados
print "DNA selvagem : $dna\n";
print "DNA mutante  : $mutant\n";

# Finaliza o programa
exit;

#################################
# Subrotinas em ordem alfabética
#################################

# Faz a mutação do DNA
sub mutate {
	my $dna = $_[0];
	my $posicao = randomposition($dna);
	my $new_base = randomnucleotide();
	substr($dna,$posicao,1,$new_base); # Altera 1 caractere da variavel $mutant na $posicao pelo $new_base
	return $dna;
}


# Seleciona um nucleotideo aleatório
sub randomnucleotide {
	my @nt = ("A", "T", "G", "C");
	return $nt [int rand scalar @nt];
}

# Seleciona uma posição aleatória
sub randomposition {
	my ($input) = @_;
	return int rand length $input;
}


