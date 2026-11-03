import 'package:confeitaria_estoque/exceptions/estoque_insuficiente_exception.dart';
import 'package:confeitaria_estoque/exceptions/quantidade_invalida_exception.dart';
import 'package:confeitaria_estoque/models/categoria.dart';
import 'package:confeitaria_estoque/models/fornecedor.dart';
import 'package:confeitaria_estoque/models/produto.dart';
import 'package:test/test.dart';

void main() {
  late Categoria categoria;
  late Fornecedor fornecedor;

  setUp(() {
    categoria = Categoria(
      id: 1,
      nome: 'Ingredientes',
    );

    fornecedor = Fornecedor(
      id: 1,
      cnpj: '00.000.000/0001-00',
      razaoSocial: 'Fornecedor Teste Ltda.',
    );
  });

  Produto criarProduto({
    double quantidade = 10,
    double minimo = 5,
  }) {
    return Produto(
      id: 1,
      sku: 'TESTE-001',
      nome: 'Produto Teste',
      unidadeMedida: 'kg',
      quantidadeEstoque: quantidade,
      estoqueMinimo: minimo,
      precoCusto: 10,
      precoVenda: 15,
      categoria: categoria,
      fornecedor: fornecedor,
    );
  }

  group('Produto - regras de estoque', () {
    test('entrada aumenta o estoque', () {
      final produto = criarProduto();

      produto.adicionarEstoque(5);

      expect(produto.quantidadeEstoque, 15);
    });

    test('saida reduz o estoque', () {
      final produto = criarProduto();

      produto.removerEstoque(4);

      expect(produto.quantidadeEstoque, 6);
    });

    test('saida maior que saldo gera excecao', () {
      final produto = criarProduto();

      expect(
        () => produto.removerEstoque(20),
        throwsA(isA<EstoqueInsuficienteException>()),
      );
    });

    test('quantidade zero ou negativa e rejeitada', () {
      final produto = criarProduto();

      expect(
        () => produto.adicionarEstoque(0),
        throwsA(isA<QuantidadeInvalidaException>()),
      );

      expect(
        () => produto.removerEstoque(-1),
        throwsA(isA<QuantidadeInvalidaException>()),
      );
    });

    test('produto identifica estoque critico', () {
      final produto = criarProduto(
        quantidade: 5,
        minimo: 5,
      );

      expect(produto.abaixoDoMinimo, isTrue);
    });
  });
}
