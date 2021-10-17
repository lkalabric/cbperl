use strict;
use warnings;
use LWP::Simple;
use Bio::SeqIO;

# Módulos do Curso Básico Perl (CBPerl)
# Os módulos estão organizados em ordem alfabética

# busca_Motif			busca motifs e retorna a(s) posição(ões) 
# DNA2proteina			traduz uma sequencia de DNA em proteina
# efetch_Genbank		faz o download de dados Fasta a partir de uma lista de números de acesso
# efetchId_Genbank		faz o download de dados Fasta a partir de uma lista de números de identificação
# esearch_Genbank		busca e faz o download de um grande volume de dados para output_efetch.txt
# escreve_Arquivo
# esearch_efetchGenbank	busca e faz o download de um grande volume de dados para output_efetch.txt
# imprime_Regua			imprime uma régua
# imprime_Sequencia 	imprime uma sequencia de comprimento definido
# IUB2regexp			traduz códigos ambiguos IUB em uma expressão regular
# le_Arquivo			lê dados de um arquivo e retorna numa variável array
# mask_Sequencia		substitui a sequencia procurada por uma mascara XXXX
# parse_esearchfile		analisa um arquivo esearch e armazena a lista de números de acesso em uma variável escalar
# parse_MSFastafile
# parse_Accessionfile	analisa um arquivo de lista de números de acesso do Genbank e armazena em uma variável escalar
# parse_Fastafile		analisa um arquivo Fasta e retorna o header a sequencia numa varável array
# parse_Rebase			analisa o arquivo Rebase (bionet.txt) e retorna o sitio e a expressão regular para busca 
# revcom				faz o reverso complemento do DNA

# Busca motifs e retorna a(s) posição(ões)
sub busca_Motif {
	my ($sequencia, $expressao_regular) = @_;
	my @posicoes;
	while ($sequencia =~ /$expressao_regular/ig) {
		# Adiciona a posição encontrada no final do array @posicoes
		push (@posicoes, pos ($sequencia) - length ($&) + 1);
	}
	return @posicoes;
}

# Traduz uma sequencia de DNA em proteina
sub DNA2proteina {
	# Recebe uma sequencia de DNA como argumento da Subrotina
    my ($dna) = @_;
	
	# Transforma todos os caracteres da string em caracteres maiúsculos
    $dna = uc $dna;

	# Declara variaveis locais
	my $proteina;
	my $codon;
    my(%codigoGenetico) = (         	# Cria o Hash codigoGenetico
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
	# Faz a tradução codon a codon
	for(my $i=0; $i < (length($dna) - 2); $i += 3){
		$codon = substr($dna,$i,3);
		$proteina .= $codigoGenetico{$codon};
	}
	return $proteina;
}

# Faz o download de dados Fasta a partir de uma lista de números de acesso
sub efetch_Genbank {
	# $db = nucleotide, protein, pubmed, gene, etc.
	my ($id_list, $db) = @_;
	
	# Assemble the efetch URL
	my $base = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
	my $reply = "&rettype=fasta&retmode=text";
	my $tool = "&tool=Basic research";
	my $email= "&email=kalabric\@bahia.fiocruz.br";
	my $url = $base . "efetch.fcgi?db=" . $db . "&id=" . $id_list . $reply. $tool . $email;
	
	# Post the efetch URL
	print "\nProcessando o download dos dados...\n";
	my $dado = get($url);
	escreve_Arquivo ($dado,"output_efetch.txt");
	print "Download concluido com sucesso!\n";
}

# Faz o download de dados Fasta a partir de um número de acesso por vez
sub efetchId_Genbank {
	# $db = nucleotide, protein, pubmed, gene, etc.
	my ($id_list, $db) = @_;
	
	# Assemble the efetch URL
	my $base = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
	my $reply = "&rettype=fasta&retmode=text";
	my $tool = "&tool=Basic research";
	my $email= "&email=kalabric\@bahia.fiocruz.br";
	my $url = $base . "efetch.fcgi?db=" . $db . $reply. $tool . $email;
	my $urlId;
	my $dado;
		
	# Converte id_list para id_array
	my @id_array = split (", ", $id_list);		
		
	# Fetch para o arquivo output_efetchId.txt
	my $i;
	foreach (@id_array) {
		$i++;
		# Post the efetch URL
		print "\nProcessando o download dos dados da sequencia ",$i,"...\n";
		$urlId =  $url . "&id=" . $_ ;
		$dado = get($urlId);
		escreve_Arquivo ($dado,">> output_efetchId.txt");
		print "Download concluido com sucesso!\n";
	}
}

# Busca e faz o download de um grande volume de dados para output_efetch.txt
sub esearch_Genbank {
	# $db = nucleotide, protein, pubmed, gene, etc.
	my ($query,$db) = @_;			
	
	# Assemble the esearch URL
	my $base = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
	my $tool = "&tool=Basic research";
	my $email= "&email=kalabric\@bahia.fiocruz.br";
	my $usehistory = "&usehistory=y";
	my $url = $base . "esearch.fcgi?db=$db&term=$query" . $tool . $email . $usehistory;
	
	# Post the esearch URL
	print "\nProcessando a busca...";
	my $output = get($url);
	escreve_Arquivo ($output,"> output_esearch.txt");
	print "Busca concluída com sucesso!\n";
	my $count = $1 if ($output =~ /<Count>(\S+)<\/Count>/);
	print "\nTotal de registros encontrados: $count\n";
	print "\nDevo baixar a lista completa de UIDs destes registros (S/N)? \n";
	my $resposta = <STDIN>;
	chomp $resposta;
	if (uc ($resposta) eq "S") {
		print "\nBaixado a lista completa de UIDs...";
		$url .= "&retmax=$count";
		$output = get($url);
		escreve_Arquivo ($output,"> output_esearch.txt");
		print "Arquivo output_eseach.txt completo salvo com sucesso!\n";
	} else {
		die "Arquivo output_eseach.txt parcial salvo com sucesso!\n";
	}
}
	
sub esearch_efetch_Genbank {
	my ($query,$db) = @_;			# Entrez Databases: pubmed, nucleotide, gene, ...
	
	# Assemble the esearch URL
	my $base = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
	my $tool = "&tool=Basic research";
	my $email= "&email=kalabric\@bahia.fiocruz.br";
	my $usehistory = "&usehistory=y";
	my $url = $base . "esearch.fcgi?db=$db&term=$query" . $tool . $email . $usehistory;
	
	# Post the esearch URL
	print "\nProcessando a busca...\n";
	my $output = get($url);
	escreve_Arquivo ($output,"output_esearch.txt");
	print "Busca concluída com sucesso!\n";
	
	# Parse WebEnv and QueryKey  para grande volume de dados
	my $web = $1 if ($output =~ /<WebEnv>(\S+)<\/WebEnv>/);
	my $key = $1 if ($output =~ /<QueryKey>(\d+)<\/QueryKey>/);
	
	# Assemble the efetch URL
	$base = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
	$tool = "&tool=Basic research";
	$email= "&email=kalabric\@bahia.fiocruz.br";
	$url = $base . "efetch.fcgi?db=$db&query_key=$key&WebEnv=$web". $tool . $email;
	$url .= "&rettype=fasta&retmode=text";
	
	# Post the efetch URL
	print "\nProcessando o download dos dados... isto pode demorar algum tempo!\n";
	my $data = get($url);
	escreve_Arquivo ($output,"output_efetch.txt");
	print "Download concluido com sucesso!\n";
}

# Escreve dados em um arquivo a partir de uma variável escalar
sub escreve_Arquivo {
	my ($dado, $nomeArquivo) = @_;	# Argumento(s)					
	defined ($nomeArquivo) or $nomeArquivo = "> output.txt";	
	open (OUTPUTHANDLE, $nomeArquivo) or die "Não foi possível abrir o arquivo \"$nomeArquivo\"\n\n";
	# > abre o arquivo para escrita e apaga tudo que estiver nele antes de escrever
	# >> abre o arquivo para escrita e adiciona o que se quer escrever ao final dele	
	print OUTPUTHANDLE $dado;		# Escreve o conteúdo da variável $dado no arquivo
	close OUTPUTHANDLE;
}


# Imprime uma régua (em desenvolvimento)
sub imprime_Regua {
	my ($comprimento) = @_; 	# Argumento(s)
	defined ($comprimento) or $comprimento = 80;
	my $regua = $comprimento/10;
	for (my $i=1; $i <= $regua; $i++) {
		print "-" x 9,$i;
	}
	print "\n";
}

# Imprime uma sequencia de comprimento definido
sub imprime_Sequencia {
	my ($sequencia, $comprimento) = @_;	# Argumento(s)
	defined ($comprimento) or $comprimento = 80;	
	for (my $pos = 0; $pos < length ($sequencia); $pos += $comprimento) {
		print substr ($sequencia,$pos,$comprimento),"\n";
	}
}

# Traduz códigos ambiguos IUB em uma expressão regular
sub IUB2regexp {
	# IUB2regexp
	#
	# A subroutine that, given a sequence with IUB ambiguity codes,
	# outputs a translation with IUB codes changed to regular expressions
	#
	# These are the IUB ambiguity codes
	# (Eur. J. Biochem. 150: 1-5, 1985):
	# R = G or A
	# Y = C or T
	# M = A or C
	# K = G or T
	# S = G or C
	# W = A or T
	# B = not A (C or G or T)
	# D = not C (A or G or T)
	# H = not G (A or C or T)
	# V = not T (A or C or G)
	# N = A or C or G or T
	# U = N (desoxiuracil)
	# I = N (desoxiinosina)
	# F = A-fosfotiato (A or T)
	# O = C-fosfotiato (C or G)
	# E = G-fosfotiato (T or G)
	# Z = T-fosfotiato (A or C)
	# . or - = gap
	my ($iub) = @_;
	my $expressao_regular = "";
	my %iub2character_class = (
		A => 'A',
		C => 'C',
		G => 'G',
		T => 'T',
		R => '[GA]',
		Y => '[CT]',
		M => '[AC]',
		K => '[GT]',
		S => '[GC]',
		W => '[AT]',
		B => '[CGT]',
		D => '[AGT]',
		H => '[ACT]',
		V => '[ACG]',
		N => '[ACGT]',
		X => '[ACGT]',
		I => '[ACGT]'
	);
	# Remove o sinal ^ (sitio de uma enzima), se presente
	$iub =~ s/\^//g;
	
	# Remove o sinal * (nucleotideos especiais), se presente
	$iub =~ s/\*//g;
	
	# Remove o sinal . ou - (gap), se presente
	$iub =~ s/\.//g; $iub =~ s/\-//g;
	
	
	# Traduz cada caracter IUB do sitio
	for ( my $i = 0 ; $i < length($iub) ; ++$i ) {
		$expressao_regular.= $iub2character_class{substr($iub, $i, 1)};
	}
	return $expressao_regular;
}
# Lê os dados de um arquivo e armazena numa variável array
sub le_Arquivo {
	my ($nomeArquivo) = @_;	# Argumento(s)					
	unless (open (INPUTHANDLE, $nomeArquivo)) {
		print "Não foi possível abrir o arquivo \"$nomeArquivo\"\n\n";
		exit;
	}
	my @dados = <INPUTHANDLE>; 				# Lê todo conteúdo em um array. Esta estratégia pode não funcionar se o tamanho do dado > memoria
	close INPUTHANDLE;
	return @dados;
}


# Substitui a sequencia procurada por uma mascara XXXX
sub mask_Sequencia {
	my ($expressao_regular, $masked_seq) = @_;
	my $tam_seq = $expressao_regular;		# Calcula o tamanho da sequencia codificada pela expressao regular
	$tam_seq =~ s/\[\w{2,4}\]/X/g; 			# Substitui a expressao regular por X 
	my $mask = "X" x length $tam_seq; 		# Cria a máscara com o tamanho da sequencia
	
	# Substitui o sequencia pela máscada
	$masked_seq =~ s/$expressao_regular/$mask/g;
	return $masked_seq;
}

# Analisa um arquivo de lista de números de acesso do Genbank e armazena em uma variável escalar
sub parse_Accessionfile {
	my ($nomeArquivo) = @_;
	my @dados = le_Arquivo ("input_accessionNumber.txt");
	foreach (@dados) {chomp $_};
	my $id_list = join (",",@dados);
	return $id_list;
}

# Analisa um arquivo esearch e armazena a lista de números de acesso em uma variável escalar
sub parse_esearchfile {
	my ($nomeArquivo) = @_;
	defined ($nomeArquivo) or $nomeArquivo = "output_esearch.txt";	
	my @dados = le_Arquivo ($nomeArquivo);
	my $id_list;
	foreach (@dados) {
		$id_list .=  $1."\n" if ($_ =~ /<Id>(\d+)<\/Id>/);
	}
	chomp $id_list; 						# Remove o último "\n"
	$id_list =~ s/\n/, /g;
	return $id_list;
}


# Lê um arquivo Fasta
sub parse_Fastafile {
	my ($nomeArquivo) = @_;							# Argumento(s)					
	my @dadosFasta = le_Arquivo($nomeArquivo);
	my $header;
	my $sequencia; 									
	foreach my $linha (@dadosFasta) {
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

# Lê um arquivo Fasta de multiplas sequencias e armazena os dados em variáveis array
sub parse_MSFastafile {
	my ($nomeArquivo) = @_;							# Argumento(s)					
	
	# Abre o arquivo Fasta
	my @linha = le_Arquivo($nomeArquivo);

	# Declada e inicializa variáveis
	my @fasta_tag;
	my @fasta_seq;
	my %sequencia;
	
	# Lê os dados do arquivo, linha-por-linha e armazena o tag e seq em dois array diferentes
	my $i_seq = -1; 	# Índice de sequencias
	foreach (@linha) {
		chomp $_;
		if ($_ =~ /^\s*$/) {
			next;
		} elsif ($_ =~ />/) {
			$i_seq++;
			$fasta_tag[$i_seq] = $_;
			
			next;
		} else {
			$fasta_seq[$i_seq] .= $_; # Concatena as linhas de sequencia numa única sequencia
		}
	}

	# Returna os dados em dois arrays diferentes
	return (@fasta_tag, @fasta_seq);
}

# Analisa o arquivo Rebase (bionet.txt) e retorna o sitio e a expressão regular para busca 
sub parse_Rebase {
	# Recebe o nome do arquivo Rebase como argumento da Subrotina
	my ($nomearquivoRebase) = @_;
	defined ($nomearquivoRebase) or $nomearquivoRebase = "bionet.txt";	
	# Declara variaveis
	my @campos;
	my $nome;
	my $sitio;
	my $expressao_regular;
	my %rebase_hash;
	#  Lê o arquivo e retorna os dados Rebase
	(open(FILEHANDLE, "< $nomearquivoRebase")) or die "Arquivo $nomearquivoRebase não pode ser aberto!\n";
	while (<FILEHANDLE>) {
		(1 .. /Rich Roberts/) and next;				# Descarta cabeçalho do arquivo
		(/^\s*$/) and next;							# Descarta linhas em branco 
		@campos = split (" ",$_);					# Separa os campos: nome, alias e sitio
		$nome = shift @campos;						# Armazena apenas o nome, primeiro elemento do array,
		$sitio = pop @campos;						# e o sitio, último elemento
		$expressao_regular = IUB2regexp ($sitio);	# Traduz os códigos ambiguos IUB para uma expressão regular
		$rebase_hash{$nome} = "$sitio $expressao_regular"; 	# Cria uma variavel hash que armazena o nome, sitios e expressão regular
	}
	close FILEHANDLE;
	return %rebase_hash;
}

# Imprime com quebra de linha \n
sub printn {
	print @_,"\n";
}

# Reverso complemento do DNA
sub revcom {
	my ($dna) = @_;
	my $revcom = uc reverse ($dna);
	$revcom =~ tr/ATCGRYMKBDV/TAGCYRKMVHB/;
	return $revcom;
}

1	# Indica fim do módulo