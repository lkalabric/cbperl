#!/usr/bin/perl
use strict;
use warnings;

# Programa: exercicio10_maskSeq.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Aprender a criar subrotinas no Perl
# a) Uso do comando or die
# a) Uso do comando open
# b) Uso do operador <filehandle>
# c) Uso do comando sub
# Sintaxe: perl exercicio10_maskSeq.v1.0.pl input_primers.txt input_sequencias.txt

# Verifica se 2 argumentos foram passados para o programa. Se negativo, imprime uma mensagem e encerra o programa 
scalar ( @ARGV ) == 2 or die "\nNúmero de argumento deve ser 2.\n\n\$ perl exercicio11_maskSeq.v1.0.pl input_primers.txt input_sequencias.txt\n\n";

# Armazena os argumentos que correspondem aos nomes dos arquivos de entrada nas respectivas variáveis
my $primers_filename = $ARGV[0];
my $sequencias_filename = $ARGV[1];

# Gera mensagem de erro se não abre o arquivo input_primers.txt
unless (open(FILEHANDLE1,$primers_filename)) {
	print "Arquivo input_primers.txt não encontrado!!!\n";
	exit;
} 

# Gera mensagem de erro se não abre o arquivo sequencias.txt
unless (open(FILEHANDLE2,$sequencias_filename)) {
	print "Arquivo input_sequencias.txt não encontrado!!!\n";
	exit;
}

# Abre os arquivos de entrada de dados e transfere seu conteúdo para as listas @primer e @sequencia
my @primer = <FILEHANDLE1>; # Lê os primers
close FILEHANDLE1;

my @sequencia = <FILEHANDLE2>;
my $sequencia = join ("",@sequencia); # Concatena todas as sequencias do arquivo no escalar $sequencia
$sequencia =~ s/\s//g; # Remove os espaços em branco da sequencia concatenada
$sequencia =~ s/\n//g; # Remove os \n da sequencia concatenada
close FILEHANDLE2;

# Declara as variáveis usadas dentro do loop for
my $revcompl;
my $primer;	
my $masked_seq = $sequencia;

# Busca cada primer na sequencia e faz o mask
foreach (@primer){     
	chomp $_;
	$primer = $_;
	$revcompl = rev_Complemento ($primer); # Determina o reverso complemento do primer
	if ($masked_seq =~ /$primer/) {
		print "Primer $primer encontrado na sequencia\n\n";
		$masked_seq = mask_Sequencia ($primer,$masked_seq); # Mascara o primer na sequencia
	} elsif ($masked_seq =~ /$revcompl/) {
		print "O rev. complemento do primer $primer foi encontrado na sequencia\n\n";
		$masked_seq = mask_Sequencia ($revcompl,$masked_seq); # Mascara o primer na sequencia
	} else {
		print "Primer $primer não encontrado!\n\n";
	}
}

# Apresenta o resultado
print "Sequencia: $sequencia\n\n";
print "Sequencia mascarada: $masked_seq\n\n";

# Erro no algoritmo
print "Este algoritmo tem um problema: ele não busca corretamente os primers degenerados!\n";
print "Para resolver isto, Precisamos converter os códigos IUPAC (RYMKBDWSN) em expressões regulares Perl.\n";

# Finaliza o programa
exit;

# Subrotinas
# Faz o reverso complemento para busca dos primers antisense na sequencia principal
sub rev_Complemento {
	my $rc = reverse @_;
	$rc =~ tr/ATCGRYMKBD/TAGCYRKMVH/;
	return $rc;
}

# Mascara o primer na sequencia
sub mask_Sequencia {
	my ($seq, $masked_seq) = @_;
	my $seq_length = length $seq; # Determina o tamanho da sequencia procurada
	my $mask = "X" x $seq_length; # Cria a máscara com o tamanho da sequencia
	
	# Substitui o sequencia pela máscada
	$masked_seq =~ s/$seq/$mask/g;
	return $masked_seq;
}