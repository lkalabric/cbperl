#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;		#  Parse file paths into directory, filename and suffix
use File::Spec;
use File::Spec::Win32;
# use File::Spec::Unix;

# Uso do módulo File::Basename
my ($fullname) = $ARGV[0];

my $datapath = 'data';

my $path_separator = "\\";
# my $path_separator = "/";
# Where $path_separator is / for Unix, \ for Windows, etc...
my $teste = dirname($datapath) . $path_separator . basename($datapath);

my @suffixlist = ('.txt','.out','.fasta');

my ($filename,$dirs,$suffix) = fileparse($fullname,@suffixlist);
$filename = fileparse($fullname,@suffixlist);
my $basename = basename($fullname,@suffixlist);
my $dirname  = dirname($fullname);

print $teste,"\n";

exit;




print $filename,"\n";
# print $basename,"\n";
# print $path,"\n";
print $dirs,"\n";
print $dirname,"\n";
print $suffix,"\n";


# Uso do módulo File::Spec
my $file = File::Spec->catfile('input.txt');
print $file,"\n";

my $curdir = File::Spec->curdir();
print $curdir,"\n";

my $rootdir = File::Spec->rootdir();
print $rootdir,"\n";

my $updir = File::Spec->updir();
print $updir,"\n";

exit;