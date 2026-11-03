import 'package:mysql_client_plus/mysql_client_plus.dart';

class FornecedorRepository {
  final MySQLConnection connection;

  FornecedorRepository(this.connection);

  Future<void> cadastrar({
    required String cnpj,
    required String razaoSocial,
    String? nomeFantasia,
    String? telefone,
    String? email,
    String? endereco,
  }) async {
    await connection.execute(
      '''
      INSERT INTO fornecedor (
        cnpj,
        razao_social,
        nome_fantasia,
        telefone,
        email,
        endereco
      )
      VALUES (
        :cnpj,
        :razaoSocial,
        :nomeFantasia,
        :telefone,
        :email,
        :endereco
      )
      ''',
      {
        'cnpj': cnpj,
        'razaoSocial': razaoSocial,
        'nomeFantasia': nomeFantasia,
        'telefone': telefone,
        'email': email,
        'endereco': endereco,
      },
    );
  }

  Future<IResultSet> listar() {
    return connection.execute(
      '''
      SELECT
        id_fornecedor,
        cnpj,
        razao_social,
        nome_fantasia,
        telefone,
        email,
        ativo
      FROM fornecedor
      WHERE ativo = TRUE
      ORDER BY COALESCE(nome_fantasia, razao_social)
      ''',
    );
  }

  Future<bool> existe(int idFornecedor) async {
    final resultado = await connection.execute(
      '''
      SELECT id_fornecedor
      FROM fornecedor
      WHERE id_fornecedor = :id
        AND ativo = TRUE
      LIMIT 1
      ''',
      {'id': idFornecedor},
    );

    return resultado.rows.isNotEmpty;
  }
}
