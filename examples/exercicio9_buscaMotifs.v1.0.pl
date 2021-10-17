#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio9_buscaMotifs.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Busca um motif em diferentes sequencias de DNA de um arquivo
# a) Uso função open
# b) Uso do operador <filehandle>
# c) Uso do comendo unless para condicional e controle de loop
# d) Uso do comando while para condicional e controle de loop
# e) Uso do operador busca /../
# Sintaxe: perl exercicio9_buscaMotifs.v1.0.pl

# Armazena o nome do arquivo de entrada de dados
my $sequencias_filename = "input_sequencias.txt";

# Forma tradicional de abrir um arquivo de entrada de dados
#open (FILEHANDLE, $sequencias_filename);

# Gera mensagem de erro se não puder abrir o arquivo sequencias.txt
unless (open(FILEHANDLE,$sequencias_filename)) {
	print "Arquivo $sequencias_filename não encontrado!!!\n";
	exit;
}

# Armazena o conteudo do arquivo numa variavel array
my @seq = <FILEHANDLE>;

# Fecha o arquivo
close FILEHANDLE;

# Declara a variavel $motif
my $motif;

# Utilizando um loop, lê um motif do teclado e reporta se ele foi achado
# Sai do programa se nenhum motif for passado
do {
	print "Entre com o motif a ser buscado (Enter, para sair): ";
	$motif = <STDIN>;

	# Remove o caracter de nova linha (\n) de $motif
	chomp $motif;

	# Salta para o fim do loop caso o $motif esteja vazio
	unless ($motif =~ /^\s*$/) {
		# Procura pelo motif nas sequencias de DNA
		foreach (@seq) {
			$_ =~ s/^\s*$//g; # Remove espaços em branco e quebras de linha "\n" , se houver
			chomp $_;
			if($_ =~ /$motif/i){
				print "Motif $motif encontrado na sequencia $_!\n\n";
			}else{
				print "Esse motif não foi encontrado na sequencia $_!\n\n";
			}
		}
	}
	
# Sai do loop caso o usuário não digite um motif
} until ($motif =~ /^\s*$/);

# Finaliza o programa
exit;