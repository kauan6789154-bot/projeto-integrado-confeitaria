import 'package:confeitaria_estoque/config/app_config.dart';
import 'package:confeitaria_estoque/exceptions/estoque_insuficiente_exception.dart';
import 'package:confeitaria_estoque/models/administrador.dart';
import 'package:confeitaria_estoque/models/categoria.dart';
import 'package:confeitaria_estoque/models/entrada.dart';
import 'package:confeitaria_estoque/models/fornecedor.dart';
import 'package:confeitaria_estoque/models/operador.dart';
import 'package:confeitaria_estoque/models/produto.dart';
import 'package:confeitaria_estoque/models/saida.dart';
import 'package:confeitaria_estoque/models/usuario.dart';
import 'package:confeitaria_estoque/services/estoque_service.dart';
import 'package:confeitaria_estoque/utils/console.dart';

void main() {
  Console.exibirCabecalho(
    AppConfig.nomeSistema,
    AppConfig.versao,
  );

  final categoria = Categoria(
    id: 1,
    nome: 'Ingredientes',
    descricao: 'Insumos utilizados na producao',
  );

  final fornecedor = Fornecedor(
    id: 1,
    cnpj: '12.345.678/0001-90',
    razaoSocial: 'Distribuidora Doce Sabor Ltda.',
    nomeFantasia: 'Doce Sabor',
  );

  final produto = Produto(
    id: 1,
    sku: 'ING-001',
    nome: 'Farinha de Trigo',
    unidadeMedida: 'kg',
    quantidadeEstoque: 25,
    estoqueMinimo: 10,
    precoCusto: 5.50,
    precoVenda: 0,
    categoria: categoria,
    fornecedor: fornecedor,
  );

  final Usuario administrador = Administrador(
    id: 1,
    nome: 'Administrador',
    email: 'admin@confeitaria.local',
  );

  final Usuario operador = Operador(
    id: 2,
    nome: 'Operador Estoque',
    email: 'operador@confeitaria.local',
  );

  print('');
  print('=== DEMONSTRACAO DE POO ===');
  print('');
  print('Usuario 1: ${administrador.resumo()}');
  print('Usuario 2: ${operador.resumo()}');
  print('');
  print('Produto antes das movimentacoes:');
  print(produto);

  final estoqueService = EstoqueService();

  final entrada = Entrada(
    id: 1,
    quantidade: 10,
    motivo: 'Compra de reposicao',
    dataHora: DateTime.now(),
    produto: produto,
    usuario: operador,
  );

  estoqueService.registrarMovimentacao(entrada);

  print('');
  print('Depois da entrada de 10 kg:');
  print(produto);

  final saida = Saida(
    id: 2,
    quantidade: 8,
    motivo: 'Uso na producao',
    dataHora: DateTime.now(),
    produto: produto,
    usuario: operador,
  );

  estoqueService.registrarMovimentacao(saida);

  print('');
  print('Depois da saida de 8 kg:');
  print(produto);

  print('');
  print('Historico:');
  for (final movimentacao in estoqueService.historico) {
    print('- ${movimentacao.descricao()}');
  }

  print('');
  print('Teste de excecao:');

  try {
    final saidaInvalida = Saida(
      id: 3,
      quantidade: 100,
      motivo: 'Teste de estoque insuficiente',
      dataHora: DateTime.now(),
      produto: produto,
      usuario: administrador,
    );

    estoqueService.registrarMovimentacao(saidaInvalida);
  } on EstoqueInsuficienteException catch (erro) {
    print('Operacao bloqueada: $erro');
  }

  print('');
  print('Estoque abaixo do minimo? ${produto.abaixoDoMinimo ? 'SIM' : 'NAO'}');
  print('Total de movimentacoes validas: ${estoqueService.totalMovimentacoes}');
}
