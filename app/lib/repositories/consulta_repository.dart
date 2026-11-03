import 'package:mysql_client_plus/mysql_client_plus.dart';

class ConsultaRepository {
  final MySQLConnection connection;

  ConsultaRepository(this.connection);

  Future<IResultSet> listarProdutosCriticos() {
    return connection.execute(
      '''
      SELECT
        p.id_produto,
        p.sku,
        p.nome,
        p.quantidade_estoque,
        p.estoque_minimo,
        p.unidade_medida,
        (p.estoque_minimo - p.quantidade_estoque) AS deficit,
        c.nome AS categoria,
        COALESCE(f.nome_fantasia, f.razao_social) AS fornecedor
      FROM produto p
      INNER JOIN categoria c
        ON c.id_categoria = p.id_categoria
      INNER JOIN fornecedor f
        ON f.id_fornecedor = p.id_fornecedor
      WHERE p.ativo = TRUE
        AND p.quantidade_estoque <= p.estoque_minimo
      ORDER BY
        (p.estoque_minimo - p.quantidade_estoque) DESC,
        p.nome
      ''',
    );
  }

  Future<IResultSet> listarHistorico({
    int limite = 30,
  }) {
    return connection.execute(
      '''
      SELECT
        m.id_movimentacao,
        m.data_hora,
        m.tipo,
        m.quantidade,
        m.motivo,
        m.observacao,
        p.id_produto,
        p.sku,
        p.nome AS produto,
        p.unidade_medida,
        u.id_usuario,
        u.nome AS usuario,
        u.perfil
      FROM movimentacao m
      INNER JOIN produto p
        ON p.id_produto = m.id_produto
      INNER JOIN usuario u
        ON u.id_usuario = m.id_usuario
      ORDER BY m.data_hora DESC, m.id_movimentacao DESC
      LIMIT :limite
      ''',
      {
        'limite': limite,
      },
    );
  }
}
