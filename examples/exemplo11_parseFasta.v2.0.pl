#!/usr/bin/perl
use strict;
use warnings;
use Bio::FASTASequence;

# Programa: exemplo_parseFasta.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-05-02
# Uso: Extrai dados de um arquivo multiplo de sequencias Fasta
# a) use Bio-FASTASequende

my $input_filename = "sequenceProt.fasta"; # armazena o nome do arquivo de entrada de dados

unless (open(INPUTHANDLE,$input_filename))
	{
		print "Arquivo não encontrado\n:";
		exit;
	}

# associa o nome do arquivo ao filehandle
# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele

# Declara a variável global $fasta
my $fasta;

# Lê os dados do arquivo e armazena na variável escalar $fasta
while (<INPUTHANDLE>) {
	$fasta .= $_;
}

close INPUTHANDLE; # fecha o arquivo input_filename

# Passa os dados Fasta para o módulo Bio::FASTASequence
my $seq = Bio::FASTASequence->new($fasta);

# Parse Fasta usando o módulo Bio::FASTASequence
my $accession = $seq->getAccessionNr();
print "Número de acesso:\n$accession\n\n";

my $description = $seq->getDescription();
print "Descrição:\n$description\n\n";

my $sequence = $seq->getSequence();
print "Sequencia:\n$sequence\n\n";

my $fasta_sequence = $seq->getFASTA();
print "FASTA:\n$fasta_sequence\n\n";

# Fim do programa
exit;