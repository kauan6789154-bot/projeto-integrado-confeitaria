import 'package:mysql_client_plus/mysql_client_plus.dart';

class CategoriaRepository {
  final MySQLConnection connection;

  CategoriaRepository(this.connection);

  Future<void> cadastrar({
    required String nome,
    String? descricao,
  }) async {
    await connection.execute(
      '''
      INSERT INTO categoria (nome, descricao)
      VALUES (:nome, :descricao)
      ''',
      {
        'nome': nome,
        'descricao': descricao,
      },
    );
  }

  Future<IResultSet> listar() {
    return connection.execute(
      '''
      SELECT id_categoria, nome, descricao, ativo
      FROM categoria
      WHERE ativo = TRUE
      ORDER BY nome
      ''',
    );
  }

  Future<bool> existe(int idCategoria) async {
    final resultado = await connection.execute(
      '''
      SELECT id_categoria
      FROM categoria
      WHERE id_categoria = :id
        AND ativo = TRUE
      LIMIT 1
      ''',
      {'id': idCategoria},
    );

    return resultado.rows.isNotEmpty;
  }
}
