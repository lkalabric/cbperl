#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo7_subRotina.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Aprender a criar, chamar e passar argumentos para uma subrotina

# Declara e inicializa as vari�veis
my $sequencia = "ATCTTG";
my @bases = ("A", "T", "C", "G");
my $tam = 10;

# Passando argumento por valor, n�o altera uma vari�vel global
print "Passando argumentos por valor:\n";
print "O valor da variavel global \$tam � $tam.\n";
print "Chamando a subrotina: calculamos que a variavel \$sequencia tem ".tam_string($sequencia)." nucleotideos.\n";
print "Depois de chamada a subrotina, o valor da variavel \$tam continua $tam!\n";

print "\nO valor da variavel global \$tam � $tam.\n";
print "Chamando a subrotina: calculamos que a variavel \@bases tem ".tam_array(@bases)." elementos.\n";
print "Depois de chamada a subrotina, o valor da variavel \$tam continua $tam!\n";

# Passando argumento por refer�ncia, altera uma vari�vel global
print "\n\nPassando argumentos por referencia:\n";
print "O valor da variavel global \$tam � $tam.\n";
print "Chamando a subrotina: calculamos que o quadrado de \$tam � ".quadrado(\$tam)."\n";
print "Depois de chamada a subrotina, o valor da variavel \$tam alterou para $tam!\n";

# Fim do programa
exit;


######
# Sub-rotinas
######

# A Fun��o tam_string calcula o tamanho de uma string
sub tam_string {
	my $tam = length $_[0];	# A variavel especial $_[0] recebe o primeiro argumento do Array
	return $tam;
}

# A Fun��o tam_array calcula o tamanho de um Array
sub tam_array {
	my $tam = scalar @_;	# A variavel especial @_ recebe o argumento Array
	return $tam;
}

# A sub-rotina quadrado calculo o quadrado de um numero
sub quadrado {
	my ($tam) = @_;
	$$tam = $$tam * $$tam;
	return $$tam;
}