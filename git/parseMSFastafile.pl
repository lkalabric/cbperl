#!/bin/perl -w
use Bio::Seq;		# M�dulo BioPerl
use Bio::SeqIO;		# M�dulo BioPerl


# Passa os nomes dos arquivos para o programa
my ($nomeArquivo_Primers, $nomeArquivo_MSFasta) = @ARGV;	# Argumento(s)					
defined ($nome_MSFastafile) or $nome_MSFastafile = "output_efetchId.txt";	

# Objeto para leitura de dados
$seqio_obj = Bio::SeqIO->new(-file => $nome_MSFastafile, 
                             -format => "fasta" );
my @dates;
							 
# L� o MSFastafile 
while ( $seq_obj = $seqio_obj->next_seq ) {
    # Imprime as informa��es da sequencia
    print $seq_obj->desc,"\t";				# Descri��o
	print $seq_obj->length,"\t";			# Tamanho da sequencia
	@dates = $seq_obj->get_dates;
	print @dates,"\t";
	# print $seq_obj->seq,"\n";				# Sequencia propriamente dita
	<STDIN>
}