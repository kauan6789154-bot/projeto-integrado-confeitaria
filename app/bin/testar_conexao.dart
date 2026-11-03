import 'package:confeitaria_estoque/config/database_config.dart';
import 'package:confeitaria_estoque/config/database_connection.dart';
import 'package:confeitaria_estoque/repositories/produto_repository.dart';

Future<void> main() async {
  print('==============================================');
  print(' TESTE DE CONEXAO DART <-> MYSQL');
  print('==============================================');

  DatabaseConnection? database;

  try {
    final config = DatabaseConfig.carregar();

    print('');
    print('Servidor: ${config.host}:${config.port}');
    print('Banco: ${config.database}');
    print('Usuario: ${config.user}');
    print('Conectando...');

    database = DatabaseConnection(config);
    final connection = await database.abrir();

    print('Conexao realizada com sucesso.');

    final info = await connection.execute(
      'SELECT DATABASE() AS banco, VERSION() AS versao',
    );

    final infoRow = info.rows.first;

    print('');
    print('Banco ativo: ${infoRow.colByName('banco')}');
    print('Versao MySQL: ${infoRow.colByName('versao')}');

    final produtoRepository = ProdutoRepository(connection);
    final produtos = await produtoRepository.listarProdutos();

    print('');
    print('PRODUTOS ENCONTRADOS NO MYSQL:');
    print('----------------------------------------------');

    if (produtos.rows.isEmpty) {
      print('Nenhum produto cadastrado.');
    } else {
      for (final row in produtos.rows) {
        final sku = row.colByName('sku');
        final nome = row.colByName('nome');
        final estoque = row.colByName('quantidade_estoque');
        final unidade = row.colByName('unidade_medida');

        print('$sku - $nome | Estoque: $estoque $unidade');
      }
    }

    print('----------------------------------------------');
    print('Total de produtos: ${produtos.numOfRows}');
    print('');
    print('TESTE CONCLUIDO COM SUCESSO.');
  } catch (erro) {
    print('');
    print('ERRO AO CONECTAR OU CONSULTAR O MYSQL:');
    print(erro);
  } finally {
    await database?.fechar();
  }
}
