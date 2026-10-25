import '../exceptions/estoque_insuficiente_exception.dart';
import '../exceptions/quantidade_invalida_exception.dart';
import 'categoria.dart';
import 'fornecedor.dart';

class Produto {
  final int id;
  final String sku;
  String nome;
  String? descricao;
  String unidadeMedida;
  double estoqueMinimo;
  double precoCusto;
  double precoVenda;
  Categoria categoria;
  Fornecedor fornecedor;
  bool ativo;

  double _quantidadeEstoque;

  Produto({
    required this.id,
    required this.sku,
    required this.nome,
    this.descricao,
    required this.unidadeMedida,
    required double quantidadeEstoque,
    required this.estoqueMinimo,
    required this.precoCusto,
    required this.precoVenda,
    required this.categoria,
    required this.fornecedor,
    this.ativo = true,
  }) : _quantidadeEstoque = quantidadeEstoque {
    if (quantidadeEstoque < 0) {
      throw QuantidadeInvalidaException(
        'A quantidade inicial do estoque nao pode ser negativa.',
      );
    }

    if (estoqueMinimo < 0) {
      throw QuantidadeInvalidaException(
        'O estoque minimo nao pode ser negativo.',
      );
    }
  }

  double get quantidadeEstoque => _quantidadeEstoque;

  bool get abaixoDoMinimo => _quantidadeEstoque <= estoqueMinimo;

  double get valorEmEstoque => _quantidadeEstoque * precoCusto;

  void adicionarEstoque(double quantidade) {
    _validarQuantidade(quantidade);
    _quantidadeEstoque += quantidade;
  }

  void removerEstoque(double quantidade) {
    _validarQuantidade(quantidade);

    if (quantidade > _quantidadeEstoque) {
      throw EstoqueInsuficienteException(
        'Produto "$nome" possui apenas '
        '${_quantidadeEstoque.toStringAsFixed(3)} $unidadeMedida em estoque.',
      );
    }

    _quantidadeEstoque -= quantidade;
  }

  void _validarQuantidade(double quantidade) {
    if (quantidade <= 0) {
      throw QuantidadeInvalidaException(
        'A quantidade deve ser maior que zero.',
      );
    }
  }

  @override
  String toString() {
    return '$sku - $nome | '
        'Estoque: ${_quantidadeEstoque.toStringAsFixed(3)} $unidadeMedida';
  }
}
