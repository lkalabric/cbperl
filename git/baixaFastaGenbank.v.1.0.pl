#!/usr/bin/perl
use strict;
use warnings;
use '../lib/CBPerl.pm';					# Módulo do curso contendo rotinas básicas
use Bio::Perl;				# Módulo básico para ler, escrever e baixar sequencias
use Bio::DB::GenBank;		# Módulo para acesso ao GenBank 
use Bio::DB::WebDBSeqI;		# Módulo para generalizar o acesso a bancos de sequencias


# Programa: baixaFastaGenbank.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2016-03-25
# Uso: Baixa sequencias do GenBank no formato Fasta

# Definição de variáveis e objetos utilizados pelo módulo Bio::DB::Genbank
my $seq;	# Armazena a sequencia
my $gb; 	# 
my $seqio;	#
my $query;	#
my $seqi;	#
my $fileout = "output.txt";	# Cria um filehandle para abrir um arquivo para escrita

# Executando o comando externo cls para limpar a tela
system("clear");

# Opções de busca
my @list_of_choices1 = ("fasta", "genbank");
my @list_of_choices2 = ("dna", "rna", "protein");
print "\nPrograma baixarSequencia(s)\n\n";
# Using the menu sub
    my $format  = menu('Formato do arquivo', \@list_of_choices1);
	my $db = menu('Banco de dados', \@list_of_choices2);
		
print "\nOpcoes: \n";
print "1. Por ID (ex.: J00522). \nNota: Nem sempre o Unique ID eh igual ao LOCUS ID!\n";
print "2. Por ACC ou LOCUS ID\ (ex.: J00522)\n";
print "3. Por Versao (ex.: J00522.1)\n";
print "4. Por gi (ex.: 405830)\n";
print "5. Por query string (ex.: Oryza sativa[Organism] AND EST)\n"; 
print "6. Por lista ACC (ex.: nome_do_arquivo.txt contendo a lista ACC, um ACC por linha)\n";
print "7. Por... ainda nao sei ...\n";
print "\nEscolha a opcao de busca [1..7]: ";

# Entra e valida a opção de busca
my $opcao = <STDIN>;
chomp $opcao;
if (($opcao < 1) or ($opcao > 7)) {
	die "Opcao invalida.\n";
}

# Entra a query string para busca
print "\nEntre a(s) palavra(s)-chave(s) ou o nome do arquivo.txt: ";
my $busca = <STDIN>;
chomp $busca;
($busca ne "") or die "Busca invalida.\n";

# Objetos do Módulo Bio::DB::Genbank, cria um novo Genbank handle 
$gb = Bio::DB::GenBank->new();
# argumentos -file => "filename", -format => 'fasta' ou 'embl' ou 'genbank'
# retorna um $seq_object com os seguintes parametros seq, id ou display_id (locus), length, accession_number, primary_id (genbank id), version, 
# namespace, authorithy, description ou desc, subseq(X,Y), alphabet (rna, dna ou protein)

if ($opcao == 1) {
	$seq = $gb->get_Seq_by_id($busca); # Unique ID, *not always the LOCUS ID*
	print "locus: ",$seq->display_id,"\n";
	print "bp: ",$seq->length,"\n";
	print "alphabet: ",$seq->alphabet,"\n";
	print "desc: ",$seq->desc,"\n";
	print "acc ",$seq->accession_number,"\n";
	print "version: ",$seq->version,"\n";
	print "gi: ",$seq->primary_id,"\n";
	print "sequecia: ",$seq->seq,"\n";
	print "Salvando arquivo $fileout ...\n";
	write_sequence (">$fileout",'fasta',$seq);  # Bio::Perl
	print "Concluido!\n";
	exit;
} elsif ($opcao == 2) {
	$seq = $gb->get_Seq_by_acc($busca); # Accession Number 
	print "locus: ",$seq->display_id,"\n";
	print "bp: ",$seq->length,"\n";
	print "alphabet: ",$seq->alphabet,"\n";
	print "desc: ",$seq->desc,"\n";
	print "acc ",$seq->accession_number,"\n";
	print "version: ",$seq->version,"\n";
	print "gi: ",$seq->primary_id,"\n";
	print "sequecia: ",$seq->seq,"\n";
	print "Salvando arquivo $fileout ...\n";
	write_sequence (">$fileout",'fasta',$seq);  # Bio::Perl
	print "Concluido!\n";
	exit;
} elsif ($opcao == 3) {
	$seq = $gb->get_Seq_by_version($busca); # Accession.version
	print "locus: ",$seq->display_id,"\n";
	print "bp: ",$seq->length,"\n";
	print "alphabet: ",$seq->alphabet,"\n";
	print "desc: ",$seq->desc,"\n";
	print "acc ",$seq->accession_number,"\n";
	print "version: ",$seq->version,"\n";
	print "gi: ",$seq->primary_id,"\n";
	print "sequecia: ",$seq->seq,"\n";
	print "Salvando arquivo $fileout ...\n";
	write_sequence (">$fileout",'fasta',$seq);  # Bio::Perl
	print "Concluido!\n";
	exit;
} elsif ($opcao == 4) { 
	$seq = $gb->get_Seq_by_gi($busca); # GI Number
	print "locus: ",$seq->display_id,"\n";
	print "bp: ",$seq->length,"\n";
	print "alphabet: ",$seq->alphabet,"\n";
	print "desc: ",$seq->desc,"\n";
	print "acc ",$seq->accession_number,"\n";
	print "version: ",$seq->version,"\n";
	print "gi: ",$seq->primary_id,"\n";
	print "sequecia: ",$seq->seq,"\n";
	print "Salvando arquivo $fileout ...\n";
	write_sequence (">$fileout",'fasta',$seq);  # Bio::Perl
	print "Concluido!\n";
	exit;
} elsif ($opcao == 5) {
	my $query = Bio::DB::Query::GenBank->new
             (-query   =>$busca,
             -reldate => '30',
             -db      => 'nucleotide');
    my $stream = $gb->get_Stream_by_query($query);
    while (my $seq =  $seqio->next_seq ) {
          print "locus: ",$seq->id,"\n";
		  print "seq length is ", $seq->length,"\n";
    }
        # or ... best when downloading very large files, prevents
        # keeping all of the file in memory
} elsif ($opcao == 6) {
    # also don't want features, just sequence so let's save bandwith
    # and request Fasta sequence
    $gb = Bio::DB::GenBank->new(-retrievaltype => 'tempfile' ,
                                                  -format => $format);
	# Cria a lista ACC a partir do arquivo ACC
	my $filein = $busca;												  
	my @lista_acc = le_Arquivo ($filein);
	foreach (@lista_acc) {
		chomp $_;
	}
	$seqio = $gb->get_Stream_by_acc([@lista_acc]);
	print "Salvando arquivo $fileout ...\n";
	while( my $seq =  $seqio->next_seq ) {
		write_sequence (">>$fileout", $format, $seq);
    }
	print "Concluido!\n";
        # note that get_Stream_by_version is not implemented
        # don't want the entire sequence or more options
} elsif ($opcao == 7) {
	$gb = Bio::DB::GenBank->new(-format => $format,
                                       -seq_start  => 100,
                                       -seq_stop   => 200,
                                       -strand     => 1,
                                       -complexity => 4);
    $seqi = $gb->get_Stream_by_query($query);
	print "sequencia: ",$seqi,"\n";
}

exit;	