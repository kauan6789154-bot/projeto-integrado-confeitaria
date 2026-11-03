import 'package:mysql_client_plus/mysql_client_plus.dart';

import '../exceptions/estoque_insuficiente_exception.dart';

class MovimentacaoRepository {
  final MySQLConnection connection;

  MovimentacaoRepository(this.connection);

  Future<double> registrarEntrada({
    required int idProduto,
    required double quantidade,
    required String motivo,
    String? observacao,
    required int idUsuario,
  }) async {
    var novoSaldo = 0.0;

    await connection.transactional((conn) async {
      final produto = await conn.execute(
        '''
        SELECT nome, quantidade_estoque
        FROM produto
        WHERE id_produto = :idProduto
          AND ativo = TRUE
        FOR UPDATE
        ''',
        {'idProduto': idProduto},
      );

      if (produto.rows.isEmpty) {
        throw ArgumentError('Produto nao encontrado ou inativo.');
      }

      final saldoAtual = double.parse(
        produto.rows.first.colByName('quantidade_estoque')!,
      );

      novoSaldo = saldoAtual + quantidade;

      await conn.execute(
        '''
        UPDATE produto
        SET quantidade_estoque = :novoSaldo
        WHERE id_produto = :idProduto
        ''',
        {
          'novoSaldo': novoSaldo,
          'idProduto': idProduto,
        },
      );

      await conn.execute(
        '''
        INSERT INTO movimentacao (
          tipo,
          quantidade,
          motivo,
          observacao,
          id_produto,
          id_usuario
        )
        VALUES (
          'ENTRADA',
          :quantidade,
          :motivo,
          :observacao,
          :idProduto,
          :idUsuario
        )
        ''',
        {
          'quantidade': quantidade,
          'motivo': motivo,
          'observacao': observacao,
          'idProduto': idProduto,
          'idUsuario': idUsuario,
        },
      );
    });

    return novoSaldo;
  }

  Future<double> registrarSaida({
    required int idProduto,
    required double quantidade,
    required String motivo,
    String? observacao,
    required int idUsuario,
  }) async {
    var novoSaldo = 0.0;

    await connection.transactional((conn) async {
      final produto = await conn.execute(
        '''
        SELECT nome, unidade_medida, quantidade_estoque
        FROM produto
        WHERE id_produto = :idProduto
          AND ativo = TRUE
        FOR UPDATE
        ''',
        {'idProduto': idProduto},
      );

      if (produto.rows.isEmpty) {
        throw ArgumentError('Produto nao encontrado ou inativo.');
      }

      final row = produto.rows.first;
      final nome = row.colByName('nome')!;
      final unidade = row.colByName('unidade_medida')!;
      final saldoAtual = double.parse(
        row.colByName('quantidade_estoque')!,
      );

      if (quantidade > saldoAtual) {
        throw EstoqueInsuficienteException(
          'Produto "$nome" possui apenas '
          '${saldoAtual.toStringAsFixed(3)} $unidade em estoque.',
        );
      }

      novoSaldo = saldoAtual - quantidade;

      await conn.execute(
        '''
        UPDATE produto
        SET quantidade_estoque = :novoSaldo
        WHERE id_produto = :idProduto
        ''',
        {
          'novoSaldo': novoSaldo,
          'idProduto': idProduto,
        },
      );

      await conn.execute(
        '''
        INSERT INTO movimentacao (
          tipo,
          quantidade,
          motivo,
          observacao,
          id_produto,
          id_usuario
        )
        VALUES (
          'SAIDA',
          :quantidade,
          :motivo,
          :observacao,
          :idProduto,
          :idUsuario
        )
        ''',
        {
          'quantidade': quantidade,
          'motivo': motivo,
          'observacao': observacao,
          'idProduto': idProduto,
          'idUsuario': idUsuario,
        },
      );
    });

    return novoSaldo;
  }
}
