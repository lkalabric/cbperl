use strict;

my @i = ("1", "2", "3");
my @j = ("a", "b", "c");

# Chamando uma subrotina por valor
print "Antes de chamar a subrotina por valor\n";
print "\@i: @i\n";
print "\@j: @j\n\n";

por_valor (@i, @j);

print "Ap�s chamar a subrotina por valor\n";
print "\@i: @i\n";	# Devido ao scope @i n�o � alterada fora da subrotina
print "\@j: @j\n";
print "Obs.: Os valores dos argumentos N�O s�o alterados fora da subrotina\n\n";

# Chamando uma subrotina por referencia
print "Antes de chamar a subrotina por referencia\n";
print "\@i: @i\n";
print "\@j: @j\n\n";

por_referencia (\@i, \@j); # Uso do \ indica que o argumento est� sendo passado por referencia

print "Ap�s chamar a subrotina por referencia\n";
print "\@i: @i\n";	# A variavel @i � alterada pela subrotina
print "\@j: @j\n";
print "Obs.: Os valores dos argumentos s�o alterados pela subrotina\n\n";

# Fim
exit;


# Subrotina
sub por_valor {
	my (@i, @j) = @_; 
	print "Dentro de uma subrotina chamada por valor\n";
	print "\@i: @i\n";
	print "\@j: @j\n\n";
	push (@i, "4");
	shift (@j);
}

sub por_referencia {
	my ($i, $j) = @_;		# Os dados passados por referencia s�o automaticamente referenciados como escales!!!
	print "Dentro de uma subrotina chamada por referencia\n";
	print "\@i: @$i\n"; 	# Para usar o valor � necess�rio derefenciar a variavel conforme o seu tipo!!!
	print "\@j: @$j\n\n";	# Isso � feito precedendo o simbolo $, @ ou % no nome da variavel (i.e. @$i indica que $i � um array)
	push (@$i, "4");
	shift (@$j);
}