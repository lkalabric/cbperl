#!/usr/bin/perl
use strict;
use warnings;
use CBPerl; # Não esqueça de incluir o módulo com as funções desenvolvidas no curso


# Programa: exercicio_Final.v1.0.pl
# Autor: Alunos curso CBPerl
# Data: 2014-12-02
# Uso: Aprender a criar subrotinas no Perl
# Sintaxe: perl exercicio_Final.v1.0.pl

# Lê do teclado o número de acesso de uma sequencia de DNA disponível no Genbank
# Vide exercicio2_entradaTeclado.v1.0.pl

# Valida a entrada, se ENTER die

# Faz o download do arquivo FASTA a partir de um número de acesso
# Utilize a subrotina efetchId_Genbank
# Os dados serão salvas no arquivo output_efetchId.txt

# Parse o arquivo FASTA
# Utilize a subrotina parse_Fastafile


# Extrai os dados do arquivo Rebase bionet.txt e 
# cria expressoes regulares a partir dos sitio de reconhecimento das enzimas
# Utilize a subrotina parse_Rebase

# Procura por todos os sitios das enzimas do arquivo Rebase bionet.txt e imprime o mapa de restrição
# my $enzima;
# foreach $enzima (sort keys %rebase_hash) {
#    ($sitio, $expressao_regular) = split (" ",$rebase_hash{$enzima});

	# Utilize a subrotina busca_Motif para encontrar o motif e suas posições
	# @posicoes = busca_Motif ($dna, $expressao_regular);

# }

# Nota: Devido ao grande volume de dados, recomendamos salvar o relatório num arquivo output.txt

# Finaliza o programa
