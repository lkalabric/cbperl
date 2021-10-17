#!/usr/bin/perl
use strict;
use warnings;
use CBPerl; # N�o esque�a de incluir o m�dulo com as fun��es desenvolvidas no curso


# Programa: exercicio_Final.v1.0.pl
# Autor: Alunos curso CBPerl
# Data: 2014-12-02
# Uso: Aprender a criar subrotinas no Perl
# Sintaxe: perl exercicio_Final.v1.0.pl

# L� do teclado o n�mero de acesso de uma sequencia de DNA dispon�vel no Genbank
# Vide exercicio2_entradaTeclado.v1.0.pl

# Valida a entrada, se ENTER die

# Faz o download do arquivo FASTA a partir de um n�mero de acesso
# Utilize a subrotina efetchId_Genbank
# Os dados ser�o salvas no arquivo output_efetchId.txt

# Parse o arquivo FASTA
# Utilize a subrotina parse_Fastafile


# Extrai os dados do arquivo Rebase bionet.txt e 
# cria expressoes regulares a partir dos sitio de reconhecimento das enzimas
# Utilize a subrotina parse_Rebase

# Procura por todos os sitios das enzimas do arquivo Rebase bionet.txt e imprime o mapa de restri��o
# my $enzima;
# foreach $enzima (sort keys %rebase_hash) {
#    ($sitio, $expressao_regular) = split (" ",$rebase_hash{$enzima});

	# Utilize a subrotina busca_Motif para encontrar o motif e suas posi��es
	# @posicoes = busca_Motif ($dna, $expressao_regular);

# }

# Nota: Devido ao grande volume de dados, recomendamos salvar o relat�rio num arquivo output.txt

# Finaliza o programa
