#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo3_manipulandoArrays.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Aprender algumas manipulações de arrays
# a) Uso da função sort
# b) Uso da função reverse
# c) Uso da função pop
# d) Uso da função shift
# e) Uso da função unshift
# f) Uso da função push
# g) Uso da função join
# h) Uso da função splice
# i) Uso da variável especial $#
# j) Uso da função scalar
# Sintaxe: perl exemplo3_manipulandoArrays.pl

# Exemplos de arrays
my @bases = ("A","T","C","G");							# Note que uma variavel array inicia com @ ao invés de $
my @proteinas = ('ATG','MYCH','CCI');					# Neste contexto apostrofo equivale a aspas
my @numeros = (1, 4, 5, 3, 2);
my @misturado = ("pi", 3.14);

system ('cls');										# Executa o comando cls diretsmente no terminal do SO

# Vamos imprimir cada elemento do array
print "Estes são os elementos do array bases: @bases\n";	# Imprimindo o Array entre aspas, os elementos serão separados por um espaço
print "Vamos imprimir um por um!\n";
print "Primeiro elemento: $bases[0]\n";						# Note que representamos o elemento com $, pois queremos apenas um valor escalar. 
															# O índice começa sempre por zero
print "Segundo elemento: $bases[1]\n";
print "Terceiro elemento: $bases[2]\n";
print "Quarto elemento: $bases[3]\n";
print "Estes são os elementos do array: ",@bases,"\n\n";	# Deste modo, os elementos serão impressos um após o outro sem espaço

# Fatiando o array
my @bases_puricas = @bases[0,3];							# Armazena A e G em @bases_puricas
my @bases_pirimidicas = @bases[1,2];						# Armazena T e C em @bases_pirimidicas
print "Fatiando o array:\n";
print "Aqui estão as bases puricas: @bases_puricas\n";		# Note que usamos @, uma vez que lidamos com mais de um valor escalar
print "Aqui estão as bases pimidicas: @bases[1,2]\n";		
print "Aqui estão alguns elementos do array números: @numeros[0,2..4]\n\n";

# Função sort e reverse - classificam os elementos do array
print "Estes são os elementos do array numeros: @numeros\n";
print "Vamos ordenar os elementos do array!\n";
my @sorted = sort @numeros;								# Classifica em os valores de @numeros em ordem crescente e armazena em @sorted
print "Aqui eles aparecem em ordem crescente @sorted\n";	# Imprimindo o Array entre aspas, seus elementos aparecerão separados por espaço
my @backwards = reverse @numeros;						# Classifica em os valores de @numeros em ordem decrescente e armazena em @backwards
print "Aqui eles aparecem em ordem decrescente: @backwards\n\n"; # Imprimindo fora das aspas, aparecerão unidos

# Função pop e shift- removem elementos do array
print "Estes são os elementos do array proteinas: @proteinas\n";
print "Vamos remover elementos do array!\n";
my $primeiro_elemento = shift @proteinas;				# shift - remove o primeiro elemento do array
print "O elemento removido foi $primeiro_elemento\n";
print "Eis os elementos remanescentes: @proteinas\n";
my $ultimo_elemento = pop @proteinas;					# pop remove o último elemento do array
print "O elemento removido foi $ultimo_elemento\n";
print "Eis os elementos remanescentes: @proteinas\n\n";

# Função unshift, push e splice - adicionam elementos num array
print "Vamos recolocar os elementos no array proteinas!\n";
unshift (@proteinas, $primeiro_elemento);					# unshift adiciona o primeiro elemento do array
print "Veja como ficou: @proteinas\n";
push (@proteinas, $ultimo_elemento);				# push - adiciona o ultimo elemento do array
print "Veja como ficou: @proteinas\n\n";
print "Também podemos incluir um elemento em uma determinada posição do array\n";
splice (@proteinas,2,0,"VLVK");
print "Veja como ficou: @proteinas\n\n"; 	

# Função join - converte um array num escalar
my $proteina = join ("",@proteinas);   # Une os elementos do array sem separadores ""
print "Eis a união das proteinas: $proteina\n\n";

# Imprime o índice do último valor de um array 
print "O índice do último valor de ",'@bases'," é $#bases\n\n";

# Tamanho do array
print "Determinando o tamanho de uma array:\n";
my $a = $#bases+1; # através da variável especial $#
print '@bases'," tem $a valores\n"; 
print "Eis, outro jeito de determinar o tamanho de um array.\n"; 
my $b = scalar @bases;
print '@bases'," tem $b valores\n";
print "Eis, outro jeito de determinar o tamanho de um array.\n"; 
my $c = @bases; # atribui uma lista a apenas uma variável
print '@bases'," tem $c valores\n";
# Isto difere de ($c) = @bases;
# (..) representa uma lista de conteúdo. 
# Neste contexto $c igual a "A", primeiro elemento do array
($c) = @bases;
print '$c = @bases é diferente de (c$) = @bases, (c$) é igual: ',"$c\n";

# Fim do programa
exit;
