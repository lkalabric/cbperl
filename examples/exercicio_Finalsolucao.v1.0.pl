#!/usr/bin/perl
use strict;
use warnings;
use CBPerl; # N�o esque�a de incluir o m�dulo com as fun��es desenvolvidas no curso

# Programa: exercicio_Finalsolucao.v1.0.pl
# Autor: Alunos curso CBPerl
# Data: 2014-12-02
# Uso: Aprender a criar subrotinas no Perl
# Sintaxe: perl exercicio_Finalsolucao.v1.0.pl

# L� do teclado o n�mero de acesso de uma sequencia de DNA dispon�vel no Genbank
print "Entrar o n�mero de acesso (ou ENTER p/sair): ";
my $numero_acesso = <STDIN>;
chomp $numero_acesso; # Remove a quebra de linha

# Valida a entrada, se ENTER die
($numero_acesso =~ /^\s*$/) and die "At� a pr�xima!\n";

# Faz o download do arquivo FASTA a partir de um n�mero de acesso
# Utilize a subrotina efetchId_Genbank
# Os dados ser�o salvas no arquivo output_efetchId.txt
efetchId_Genbank ($numero_acesso, "nucleotide");

# Parse o arquivo FASTA
# Utilize a subrotina parse_Fastafile
my ($header, $sequencia) = parse_Fastafile ("output_efetchId.txt");

# Extrai os dados do arquivo Rebase bionet.txt e 
# cria expressoes regulares a partir dos sitio de reconhecimento das enzimas
# Utilize a subrotina parse_Rebase
my $nomearquivoRebase = "bionet.txt";
my %rebase_hash = parse_Rebase ($nomearquivoRebase);

# Procura por todos os sitios das enzimas do arquivo Rebase bionet.txt e imprime o mapa de restri��o
my $enzima;
my $sitio;
my $expressao_regular;
my @posicoes;
foreach $enzima (sort keys %rebase_hash) {
    ($sitio, $expressao_regular) = split (" ",$rebase_hash{$enzima});
	# Cria o mapa de restricao
	@posicoes = busca_Motif ($sequencia, $expressao_regular);
	# Imprime o mapa de restricao
	if (@posicoes) {
		print "Os s�tios de restri��o para $enzima $sitio s�o:\n";
		print join (" ",@posicoes),"\n\n";
	} else {
		print "N�o h� sitios para $enzima no DNA\n\n";
	}
}

# Finaliza o programa
exit;
