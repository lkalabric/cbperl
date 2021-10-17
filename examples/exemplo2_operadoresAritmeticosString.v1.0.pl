#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo2_operadoresAritmeticosString.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Aprender a sintaxe dos operadores aritm�ticos e de strings em Perl
# Sintaxe: perl exemplo2_operadoresAritmeticosString.v1.0.pl

# Inicializa as vari�veis
my $distancia = 10;
my $tempo = 5;
my $largura = 3;
my $profundidade = 3;
my $altura = 3;
my $pi = 3.14;
my $raio = 180;
my $numero = 5;

# Operadores aritmeticos
# Calcula a velocidade
print "Dist�ncia = $distancia\n";
print "Tempo = $tempo\n";
my $velocidade = $distancia / $tempo;
print "Velocidade = $velocidade\n\n";

# Calcula o volume
print "Largura = $largura, Profunidade = $profundidade, Altura= $altura\n";
my $volume = $largura * $profundidade * $altura;
print "Volume = $volume\n\n";

# Calcula a �rea da circunfer�ncia
print "Pi = $pi\n";
print "Raio = $raio\n";
my $area = $pi * ($raio ** 2);
print "�rea da circunfer�ncia = $area\n\n";

# Calcula o resto da divis�o por 2
print "N�mero = $numero\n";
my $resto = $numero % 2;
print "Resto da divis�o por 2 = $resto\n\n";

# Outros c�lculos
my $x = $distancia + 5;
$x = $x + 1;
$x += 1;
$x++;
print "Uso dos operadores de soma $x\n\n";

my $y = 10;
$y = $y - 1;
$y -= 1;
$y--;
print "Uso dos operadores de substra��o $y\n\n";

# Operadores de string
my $nome = "Nome";
my $sobrenome = "Sobrenome";
my $nomeCompleto = $nome . " " . $sobrenome;
my $tandem = "AT" x 10;

print "Nome = $nome\n";
print "Sobrenome = $sobrenome\n";
print "Nome completo = $nomeCompleto\n";
print "Repeti��o = $tandem\n";

# Finaliza o programa
exit;