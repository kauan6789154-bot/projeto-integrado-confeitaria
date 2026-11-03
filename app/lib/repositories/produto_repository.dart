import 'package:mysql_client_plus/mysql_client_plus.dart';

class ProdutoRepository {
  final MySQLConnection connection;

  ProdutoRepository(this.connection);

  Future<IResultSet> listarProdutos() {
    return connection.execute(
      '''
      SELECT
        id_produto,
        sku,
        nome,
        quantidade_estoque,
        estoque_minimo,
        unidade_medida
      FROM produto
      ORDER BY id_produto
      ''',
    );
  }
}
