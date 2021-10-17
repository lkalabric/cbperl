#!/usr/bin/perl
use strict;
use warnings;
use CBPerl;

# Programa: exercicio12_parseFastafile.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Ler um arquivo Fasta com sequencia unica e traduz a proteina

# Chama a subrotina que lê os dados de um arquivo
my @dadoArquivo = lerArquivo ("input_fastaFile.txt");

# Chama a subrotina que extraí o header e a sequencia do arquivo Fasta
(my $header, my $sequencia) = ler_dadoFasta (@dadoArquivo);

print $header,"\n";
print $sequencia,"\n\n";

# Traduz DNA em proteina
my $proteina = traduz_DNA2protein ($sequencia);

print $header,"\n";
print $proteina,"\n\n";

# Finaliza o programa
exit;

# Transfere todos os dados de um arquivo linha por linha para um array
sub lerArquivo {
	my ($input) = @_;						

	unless (open (INPUTHANDLE, $input)) {
		print "Não foi possível abrir o arquivo \"$input\"\n\n";
		exit;
	}
	@dadoArquivo = <INPUTHANDLE>; 				# Lê todo conteúdo em um array. Esta estratégia pode não funcionar se o tamanho do dado > memoria
	close INPUTHANDLE;
	return @dadoArquivo;
}

# Extrai os dados do arquivo Fasta
sub ler_dadoFasta {
	my @input = @_;
	my $header;
	my $sequencia; # Declara a variavel
	foreach my $linha (@input) {
		
		# Remove a quebra de linha
		chomp $linha; 
		
		# Descata linha em branco
		if ($linha =~ /^\s*$/) {
			next;
		
		# Extrai o header da sequencia
		} elsif ($linha =~ /^>/) {
			$header = $linha;
			next;
		} else {
			$sequencia .= $linha;
		}
	}
	return ($header, $sequencia);
}
