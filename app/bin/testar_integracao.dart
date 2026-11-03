import 'package:confeitaria_estoque/config/database_config.dart';
import 'package:confeitaria_estoque/config/database_connection.dart';

Future<void> main() async {
  print('==============================================');
  print(' TESTE DE INTEGRACAO - PROJETO INTEGRADO');
  print('==============================================');

  DatabaseConnection? database;
  var falhas = 0;

  try {
    final config = DatabaseConfig.carregar();
    database = DatabaseConnection(config);
    final connection = await database.abrir();

    print('');
    print('[OK] Conexao com MySQL');

    final banco = await connection.execute(
      'SELECT DATABASE() AS banco',
    );

    final nomeBanco = banco.rows.first.colByName('banco');

    if (nomeBanco == 'confeitaria_estoque') {
      print('[OK] Schema ativo: confeitaria_estoque');
    } else {
      print('[FALHA] Schema ativo inesperado: $nomeBanco');
      falhas++;
    }

    final tabelas = await connection.execute(
      '''
      SELECT COUNT(*) AS total
      FROM information_schema.tables
      WHERE table_schema = 'confeitaria_estoque'
        AND table_name IN (
          'usuario',
          'categoria',
          'fornecedor',
          'produto',
          'movimentacao'
        )
      ''',
    );

    final totalTabelas = int.parse(
      tabelas.rows.first.colByName('total')!,
    );

    if (totalTabelas == 5) {
      print('[OK] 5 tabelas principais encontradas');
    } else {
      print('[FALHA] Foram encontradas $totalTabelas de 5 tabelas');
      falhas++;
    }

    final usuarios = await connection.execute(
      '''
      SELECT COUNT(*) AS total
      FROM usuario
      WHERE ativo = TRUE
      ''',
    );

    final totalUsuarios = int.parse(
      usuarios.rows.first.colByName('total')!,
    );

    if (totalUsuarios >= 2) {
      print('[OK] Usuarios ativos encontrados: $totalUsuarios');
    } else {
      print('[FALHA] Quantidade insuficiente de usuarios ativos');
      falhas++;
    }

    final produtos = await connection.execute(
      '''
      SELECT COUNT(*) AS total
      FROM produto
      WHERE ativo = TRUE
      ''',
    );

    final totalProdutos = int.parse(
      produtos.rows.first.colByName('total')!,
    );

    if (totalProdutos > 0) {
      print('[OK] Produtos ativos encontrados: $totalProdutos');
    } else {
      print('[FALHA] Nenhum produto ativo encontrado');
      falhas++;
    }

    final movimentacoes = await connection.execute(
      '''
      SELECT COUNT(*) AS total
      FROM movimentacao
      ''',
    );

    final totalMovimentacoes = int.parse(
      movimentacoes.rows.first.colByName('total')!,
    );

    print('[OK] Movimentacoes registradas: $totalMovimentacoes');

    final integridade = await connection.execute(
      '''
      SELECT COUNT(*) AS inconsistencias
      FROM movimentacao m
      LEFT JOIN produto p
        ON p.id_produto = m.id_produto
      LEFT JOIN usuario u
        ON u.id_usuario = m.id_usuario
      WHERE p.id_produto IS NULL
         OR u.id_usuario IS NULL
      ''',
    );

    final inconsistencias = int.parse(
      integridade.rows.first.colByName('inconsistencias')!,
    );

    if (inconsistencias == 0) {
      print('[OK] Integridade das movimentacoes');
    } else {
      print('[FALHA] $inconsistencias movimentacoes inconsistentes');
      falhas++;
    }

    final criticos = await connection.execute(
      '''
      SELECT COUNT(*) AS total
      FROM produto
      WHERE ativo = TRUE
        AND quantidade_estoque <= estoque_minimo
      ''',
    );

    final totalCriticos = int.parse(
      criticos.rows.first.colByName('total')!,
    );

    print('[OK] Consulta de estoque minimo: $totalCriticos produto(s) critico(s)');

    print('');
    print('==============================================');

    if (falhas == 0) {
      print(' RESULTADO: INTEGRACAO APROVADA');
    } else {
      print(' RESULTADO: $falhas FALHA(S) ENCONTRADA(S)');
    }

    print('==============================================');
  } catch (erro) {
    print('');
    print('[FALHA] Nao foi possivel concluir o teste.');
    print('Detalhes: $erro');
  } finally {
    await database?.fechar();
  }
}
