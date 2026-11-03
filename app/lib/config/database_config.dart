import 'dart:io';

class DatabaseConfig {
  final String host;
  final int port;
  final String user;
  final String password;
  final String database;

  const DatabaseConfig({
    required this.host,
    required this.port,
    required this.user,
    required this.password,
    required this.database,
  });

  static DatabaseConfig carregar({String arquivo = '.env'}) {
    final file = File(arquivo);

    if (!file.existsSync()) {
      throw StateError(
        'Arquivo $arquivo nao encontrado. '
        'Copie .env.example para .env e preencha os dados do banco.',
      );
    }

    final valores = <String, String>{};

    for (final linhaOriginal in file.readAsLinesSync()) {
      final linha = linhaOriginal.trim();

      if (linha.isEmpty || linha.startsWith('#')) {
        continue;
      }

      final separador = linha.indexOf('=');
      if (separador <= 0) {
        continue;
      }

      final chave = linha.substring(0, separador).trim();
      var valor = linha.substring(separador + 1).trim();

      if (valor.length >= 2 &&
          ((valor.startsWith('"') && valor.endsWith('"')) ||
              (valor.startsWith("'") && valor.endsWith("'")))) {
        valor = valor.substring(1, valor.length - 1);
      }

      valores[chave] = valor;
    }

    String obrigatorio(String chave) {
      final valor = valores[chave];

      if (valor == null || valor.isEmpty) {
        throw StateError('Configuracao obrigatoria ausente: $chave');
      }

      return valor;
    }

    return DatabaseConfig(
      host: obrigatorio('DB_HOST'),
      port: int.parse(obrigatorio('DB_PORT')),
      user: obrigatorio('DB_USER'),
      password: obrigatorio('DB_PASSWORD'),
      database: obrigatorio('DB_NAME'),
    );
  }
}
