#!/usr/bin/perl
use strict;
use warnings;
use CBPerl;

# Programa: exemplo_buscaMutacao.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-08-12
# Uso: Busca mutacoes

# Notação:
# D111E - Substituicao de aa D (tipo selvagem) na posicao 111 pelo aa E (tipo mutante)
# deltaF59 - Deleção do aa F (tipo selvagem) na posicao 59

# Declara e inicializa variaveis globais
my @dna = ("ATTAGCCCATGCTACTTAGTATATGAGACAGACTACACATACATG", "ATTAGCCCATGCTACTTAGTATATGAGACAGAaTACACATACATG", "ATTAGCCCATGCTACTTAGTATATGAGACAGtCTACACATACATG");
my $deslocamento = 100; # Posicao relativa ao aa amino-terminal
my $mutacao = "D111E";
my $proteina;

# Chama a subrotina para traduzir o $dna
foreach (@dna) {
	$proteina = DNA2proteina ($_);
	imprime_Regua($deslocamento);
	print $proteina,"\n";
	buscaMutacao($deslocamento, $mutacao, $proteina);
}


# Fim
exit;

sub buscaMutacao {
	my ($deslocamento, $mutacao, $proteina) = @_;
	
	# Determina o aa selvagem
	my $aa_selvagem = substr($mutacao,0,1);
	
	# Determina a posicao da mutacao
	my $posicaoAbsoluta = substr($mutacao,1,(length $mutacao)-2);
	my $posicaoRelativa = substr($mutacao,1,(length $mutacao)-2)-$deslocamento-1;
		
	# Determina o aa mutante
	my $aa_mutante = substr($mutacao,(length $mutacao)-1,1);
	
	# Determina o aa do sitio mutante
	my $aa_sitioMutante = substr($proteina,$posicaoRelativa,1);
	
	if ($aa_sitioMutante eq $aa_mutante) {
		print "Mutacao $mutacao encontrada\n\n";
	} elsif ($aa_sitioMutante eq $aa_selvagem) {
		print "Mutacao $mutacao não encontrada (tipo selvagem)!\n\n";
	} else {
		print "Outra mutação encontrada $aa_selvagem$posicaoAbsoluta$aa_sitioMutante!\n\n";
	}
}


