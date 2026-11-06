import 'package:mysql_client_plus/mysql_client_plus.dart';

class ProdutoRepository {
  final MySQLConnection connection;

  ProdutoRepository(this.connection);

  Future<void> cadastrar({
    required String sku,
    required String nome,
    String? descricao,
    required String unidadeMedida,
    required double quantidadeEstoque,
    required double estoqueMinimo,
    required double precoCusto,
    required double precoVenda,
    required int idCategoria,
    required int idFornecedor,
  }) async {
    await connection.execute(
      '''
      INSERT INTO produto (
        sku,
        nome,
        descricao,
        unidade_medida,
        quantidade_estoque,
        estoque_minimo,
        preco_custo,
        preco_venda,
        id_categoria,
        id_fornecedor
      )
      VALUES (
        :sku,
        :nome,
        :descricao,
        :unidadeMedida,
        :quantidadeEstoque,
        :estoqueMinimo,
        :precoCusto,
        :precoVenda,
        :idCategoria,
        :idFornecedor
      )
      ''',
      {
        'sku': sku,
        'nome': nome,
        'descricao': descricao,
        'unidadeMedida': unidadeMedida,
        'quantidadeEstoque': quantidadeEstoque,
        'estoqueMinimo': estoqueMinimo,
        'precoCusto': precoCusto,
        'precoVenda': precoVenda,
        'idCategoria': idCategoria,
        'idFornecedor': idFornecedor,
      },
    );
  }

  Future<IResultSet> listarProdutos() {
    return connection.execute(
      '''
      SELECT
        p.id_produto,
        p.sku,
        p.nome,
        p.quantidade_estoque,
        p.estoque_minimo,
        p.unidade_medida,
        p.preco_custo,
        p.preco_venda,
        c.nome AS categoria,
        COALESCE(f.nome_fantasia, f.razao_social) AS fornecedor
      FROM produto p
      INNER JOIN categoria c
        ON c.id_categoria = p.id_categoria
      INNER JOIN fornecedor f
        ON f.id_fornecedor = p.id_fornecedor
      WHERE p.ativo = TRUE
      ORDER BY p.nome
      ''',
    );
  }

  Future<bool> existe(int idProduto) async {
    final resultado = await connection.execute(
      '''
      SELECT id_produto
      FROM produto
      WHERE id_produto = :id
        AND ativo = TRUE
      LIMIT 1
      ''',
      {'id': idProduto},
    );

    return resultado.rows.isNotEmpty;
  }

  Future<void> remover(int idProduto) async {
    await connection.execute(
      '''
      UPDATE produto
      SET ativo = FALSE
      WHERE id_produto = :id
      ''',
      {'id': idProduto},
    );
  }
}
