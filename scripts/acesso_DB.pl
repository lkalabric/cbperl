#!/usr/bin/perl
use DBI;
if($#ARGV<1){
	die "Modo de uso: perl parserBlastTable.pl <nome do arquivo blast> <query accession id>\nExemplo: perl parserBlastTable.pl Alignment-HitTable.csv CAI64586.1";
}
my $arquivo = ARGV[0];
my $query = ARGV[1];
my $DATABASE = 'edilson_pcrinsilico';
my $TABLE = 'organism';
my $CONFIG = ";mysql_read_default_file=/home/kalabric/.my.cnf";
my $dbh = DBI->connect("DBI:mysql:$DATABASE".$CONFIG,,) or  die "Não foi possível conectar no banco de dados '$DATABASE'\n";
my $sth;
open(IN, "<$arquivo") or die "Não foi possivel abrir arquivo de entrada : '$arquivo'\n";
my @campos;
my $SQL_INSERT;
my $genero;
while (<IN>){
