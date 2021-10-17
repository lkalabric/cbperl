use File::Path;

# Cria o diretório caso não exista
@created = mkpath('ola');
@created = mkpath('..\data\ola');
