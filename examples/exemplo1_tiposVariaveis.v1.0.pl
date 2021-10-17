#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo1_tiposVariaveis.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Aprender a declarar e inicializar diferentes tipos de vari�veis em Perl e usar o comando print
# Sintaxe: perl exemplo1_tiposVariaveis.v1.0.pl

# Vari�veis escalares
my $dna = "ATCTGTGACTTAAA";
my $rna = 'AUCUGUGACUUAAA';		# Neste contexto aspas e apostrofo s�o equivalentes
my $numNt = 14;
my $massa = 153.72;

# Uso geral do comando print
print "\n### Imprimindo strings e variaveis escalares ###\n";
print "Esta � a sequencia de DNA armazenada: $dna\n";
print 'Ele codifica o RNA: $rna\n'; # Neste contexto aspas e apostrofos s�o diferentes
print "A sequencia de DNA tem $numNt pares de base e o RNA tem $numNt nucleot�deos.\n";

# Vari�veis tipo array
my @numeros = (1 .. 5);			# Atribuindo listas (..) a um Array
@numeros[5, 6] = (6, 7);
my @misturado = ("pi", 3.14);
my @fatia = (1 .. 10);
@fatia[4, 7 .. 9 ] = ("quatro", "sete", "oito", "nove"); 
my @bases = ('A','T','C','G'); 	# Neste contexto apostrofo � equivalente a aspas
$bases[4] = "N"; 				# Veja que o elemento de um Array � um escalar $
			
print "\n### Imprimindo variaveis array ###\n";
print "@bases\n";
print @numeros."\n";
print @misturado,"\n";
print $bases[0],"\n";	# O elemento do array � identificado pelo seu indice 0, 1, 2...
print @fatia,"\n";
print @fatia[1, 4..6],"\n";
print "Colocar \"aspas\" numa string � relativamente simples!\n";  # Vide metacaracteres (Exemplo: \", \n, etc.)

# Vari�veis tipo hash
my %nt_nome = ("A","adenosina","T","timidina","C","citidina","G","guanosina"); # O primeiro elemento � a chave, o segundo � o valor
my %base_nome = ("A" => "adenina",
				 "T" => "timina",
				 "C" => "citosina",
				 "G" => "guanina");	# O s�mbolo => torna mais f�cil ler a hash 

print "\n### Imprimindo variaveis hash ###\n";
print $nt_nome{"A"},"\n"; 			# O elemento de um hash � identificado por sua chave. 
									# Veja que um elemento da hash tamb�m � um escalar $
print @base_nome{"A", "T"},"\n\n"; 	# Uma lista (> 1 elemento) hash j� � um array @
my $indice = "A";
print "O nucleot�deo $nt_nome{$indice} � representado pela letra $indice\n";

# Outras formas de usar o comando print
print "Eis uma sequencia de RNA: ",$rna,"\n";	# V�rgula concatena duas strings
print '24 bananas ao pre�o de $preco cada\n'; 	# Apostrofo n�o imprime o valor de $preco
print "O quadrado de $numeros[1] � ", $numeros[1] * $numeros[1],"\n"; # Virgula concatena strings
print $bases[0],"\n";				# imprime A
print @bases[0],"\n";				# imprime A, mas gera um warning! Por que?
