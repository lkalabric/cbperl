#!/usr/bin/perl
use strict;
use warnings;

# Programa: exemplo9_traduzDNA2Proteina.v1.0.pl
# Autor: Luciano Kalabric
# Data: 2014-11-08
# Uso: Traduz uma sequencia de DNA para Proteina
# Sintaxe: perl exemplo9_traduzDNA2Proteina.v1.0.pl

# Inicializa variáveis
my $dna = 'CGACGTCTTCGTACGGGACTAGCTCGTGTCGGTCGC';
my $proteina = '';
my $codon;

# Traduz cada códon de três bases em um aminoácido e concatena à proteína   
# O for continua enquanto i for menor que (length(@dna) -2) 
# porque i = (length($dna) - 2) significa que não se tem mais 3 bases para serem lidas, apenas duas
# (lembre-se que a primeira posição da string é 0, a última é (length($dna) -1) e o i é incrementado de 3 em 3)
for(my $i=0; $i < (length($dna) - 2); $i += 3){
     $codon = substr($dna,$i,3);
     $proteina .= codon2aa($codon);
}
print "O DNA\n$dna\n\ncodifica a proteina\n$proteina\n\n";
exit;

###################################################################################################
############## SUBROTINAS ########################################################################
#
# codon2aa
#
# Uma subrotina que traduz 3 caracteres de DNA para um aminoácido
#   Versão 3, usando hash

sub codon2aa {
# Recebe os parâmetros da Subrotina
    my ($codon) = @_;

# Transforma todos os caracteres da string em caracteres maiúsculos
    $codon = uc $codon;
 
# Cria o Hash codigoGenetico
    my(%codigoGenetico) = (         
        'TCA' => 'S',    # Serina
        'TCC' => 'S',    # Serina
        'TCG' => 'S',    # Serina
        'TCT' => 'S',    # Serina
        'TTC' => 'F',    # Fenilalanina
        'TTT' => 'F',    # Fenilalanina
        'TTA' => 'L',    # Leucina
        'TTG' => 'L',    # Leucina
        'TAC' => 'Y',    # Tirosina
        'TAT' => 'Y',    # Tirosina
        'TAA' => '#',    # Parada
        'TAG' => '+',    # Parada
        'TGC' => 'C',    # Cisteína
        'TGT' => 'C',    # Cisteína
        'TGA' => '*',    # Parada
        'TGG' => 'W',    # Triptofano
        'CTA' => 'L',    # Leucina
        'CTC' => 'L',    # Leucina
        'CTG' => 'L',    # Leucina
        'CTT' => 'L',    # Leucina
        'CCA' => 'P',    # Prolina
        'CCC' => 'P',    # Prolina
		'CCG' => 'P',    # Prolina
        'CCT' => 'P',    # Prolina
        'CAC' => 'H',    # Histidina
        'CAT' => 'H',    # Histidina
        'CAA' => 'Q',    # Glutamina
        'CAG' => 'Q',    # Glutamina
        'CGA' => 'R',    # Arginina
        'CGC' => 'R',    # Arginina
        'CGG' => 'R',    # Arginina
        'CGT' => 'R',    # Arginina
        'ATA' => 'I',    # Isoleucina
        'ATC' => 'I',    # Isoleucina
        'ATT' => 'I',    # Isoleucina
        'ATG' => 'M',    # Metionina
        'ACA' => 'T',    # Treonina
        'ACC' => 'T',    # Treonina
        'ACG' => 'T',    # Treonina
        'ACT' => 'T',    # Treonina
        'AAC' => 'N',    # Asparagina
        'AAT' => 'N',    # Asparagina
        'AAA' => 'K',    # Lisina
        'AAG' => 'K',    # Lisina
        'AGC' => 'S',    # Serina
        'AGT' => 'S',    # Serina
        'AGA' => 'R',    # Arginina
        'AGG' => 'R',    # Arginina
        'GTA' => 'V',    # Valina
        'GTC' => 'V',    # Valina
        'GTG' => 'V',    # Valina
        'GTT' => 'V',    # Valina
        'GCA' => 'A',    # Alanina
        'GCC' => 'A',    # Alanina
        'GCG' => 'A',    # Alanina
        'GCT' => 'A',    # Alanina
        'GAC' => 'D',    # Ácido Aspártico
        'GAT' => 'D',    # Ácido Aspártico
        'GAA' => 'E',    # Ácido Glutâmico
        'GAG' => 'E',    # Ácido Glutâmico
        'GGA' => 'G',    # Glicina
        'GGC' => 'G',    # Glicina
        'GGG' => 'G',    # Glicina
        'GGT' => 'G',    # Glicina
    );

# Se o códon procurado estiver no hash, retornamos a proteína correspondente.
# Se não estiver, exibimos uma saída de erro.
    if(exists $codigoGenetico{$codon}) {
        return $codigoGenetico{$codon};
    }else{
       print STDERR "Erro no códon \"$codon\"!!\n";
       exit;
    }
}
