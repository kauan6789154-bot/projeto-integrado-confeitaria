import '../models/usuario.dart';
import '../repositories/categoria_repository.dart';
import '../repositories/fornecedor_repository.dart';
import '../repositories/produto_repository.dart';
import '../services/cadastro_service.dart';
import '../services/movimentacao_service.dart';
import 'console.dart';
import 'input_utils.dart';

class MenuPrincipal {
  final Usuario usuario;
  final CadastroService cadastroService;
  final MovimentacaoService movimentacaoService;
  final CategoriaRepository categoriaRepository;
  final FornecedorRepository fornecedorRepository;
  final ProdutoRepository produtoRepository;

  MenuPrincipal({
    required this.usuario,
    required this.cadastroService,
    required this.movimentacaoService,
    required this.categoriaRepository,
    required this.fornecedorRepository,
    required this.produtoRepository,
  });

  Future<void> executar() async {
    while (true) {
      print('');
      Console.linha();
      print('MENU PRINCIPAL - ${usuario.perfil}');
      Console.linha();
      print('1 - Listar produtos');
      print('2 - Listar categorias');
      print('3 - Listar fornecedores');
      print('4 - Registrar entrada de estoque');
      print('5 - Registrar saida de estoque');
      print('6 - Cadastrar categoria');
      print('7 - Cadastrar fornecedor');
      print('8 - Cadastrar produto');
      print('0 - Sair');

      final opcao = InputUtils.lerTexto('Opcao: ');

      try {
        switch (opcao) {
          case '1':
            await _listarProdutos();
            break;
          case '2':
            await _listarCategorias();
            break;
          case '3':
            await _listarFornecedores();
            break;
          case '4':
            await _registrarEntrada();
            break;
          case '5':
            await _registrarSaida();
            break;
          case '6':
            await _cadastrarCategoria();
            break;
          case '7':
            await _cadastrarFornecedor();
            break;
          case '8':
            await _cadastrarProduto();
            break;
          case '0':
            print('');
            print('Sessao encerrada.');
            return;
          default:
            print('');
            print('Opcao invalida.');
        }
      } catch (erro) {
        print('');
        print('Nao foi possivel concluir a operacao.');
        print('Detalhes: $erro');
      }
    }
  }

  Future<void> _listarCategorias() async {
    final resultado = await categoriaRepository.listar();

    print('');
    print('CATEGORIAS');
    print('----------------------------------------------');

    for (final row in resultado.rows) {
      print(
        '${row.colByName('id_categoria')} - '
        '${row.colByName('nome')}',
      );
    }

    print('----------------------------------------------');
    print('Total: ${resultado.numOfRows}');
  }

  Future<void> _listarFornecedores() async {
    final resultado = await fornecedorRepository.listar();

    print('');
    print('FORNECEDORES');
    print('----------------------------------------------');

    for (final row in resultado.rows) {
      final nomeFantasia = row.colByName('nome_fantasia');
      final razaoSocial = row.colByName('razao_social');
      final nome = (nomeFantasia == null || nomeFantasia.isEmpty)
          ? razaoSocial
          : nomeFantasia;

      print(
        '${row.colByName('id_fornecedor')} - '
        '$nome | CNPJ: ${row.colByName('cnpj')}',
      );
    }

    print('----------------------------------------------');
    print('Total: ${resultado.numOfRows}');
  }

  Future<void> _listarProdutos() async {
    final resultado = await produtoRepository.listarProdutos();

    print('');
    print('PRODUTOS');
    print('----------------------------------------------');

    for (final row in resultado.rows) {
      print(
        '${row.colByName('id_produto')} | '
        '${row.colByName('sku')} | '
        '${row.colByName('nome')} | '
        'Estoque: ${row.colByName('quantidade_estoque')} '
        '${row.colByName('unidade_medida')} | '
        'Minimo: ${row.colByName('estoque_minimo')} | '
        'Categoria: ${row.colByName('categoria')} | '
        'Fornecedor: ${row.colByName('fornecedor')}',
      );
    }

    print('----------------------------------------------');
    print('Total: ${resultado.numOfRows}');
  }

  Future<void> _registrarEntrada() async {
    print('');
    print('REGISTRAR ENTRADA DE ESTOQUE');
    await _listarProdutos();

    final idProduto = InputUtils.lerInt('ID do produto: ');
    final quantidade = InputUtils.lerDouble('Quantidade de entrada: ');

    if (idProduto == null || quantidade == null) {
      throw ArgumentError('Produto ou quantidade invalida.');
    }

    final motivo = InputUtils.lerTexto('Motivo: ');
    final observacao = InputUtils.lerTexto('Observacao (opcional): ');

    final novoSaldo = await movimentacaoService.registrarEntrada(
      usuario: usuario,
      idProduto: idProduto,
      quantidade: quantidade,
      motivo: motivo,
      observacao: observacao,
    );

    print('');
    print('Entrada registrada com sucesso.');
    print('Novo saldo do produto: ${novoSaldo.toStringAsFixed(3)}');
  }

  Future<void> _registrarSaida() async {
    print('');
    print('REGISTRAR SAIDA DE ESTOQUE');
    await _listarProdutos();

    final idProduto = InputUtils.lerInt('ID do produto: ');
    final quantidade = InputUtils.lerDouble('Quantidade de saida: ');

    if (idProduto == null || quantidade == null) {
      throw ArgumentError('Produto ou quantidade invalida.');
    }

    final motivo = InputUtils.lerTexto('Motivo: ');
    final observacao = InputUtils.lerTexto('Observacao (opcional): ');

    final novoSaldo = await movimentacaoService.registrarSaida(
      usuario: usuario,
      idProduto: idProduto,
      quantidade: quantidade,
      motivo: motivo,
      observacao: observacao,
    );

    print('');
    print('Saida registrada com sucesso.');
    print('Novo saldo do produto: ${novoSaldo.toStringAsFixed(3)}');
  }

  Future<void> _cadastrarCategoria() async {
    print('');
    print('CADASTRO DE CATEGORIA');

    final nome = InputUtils.lerTexto('Nome: ');
    final descricao = InputUtils.lerTexto('Descricao (opcional): ');

    await cadastroService.cadastrarCategoria(
      usuario: usuario,
      nome: nome,
      descricao: descricao,
    );

    print('Categoria cadastrada com sucesso.');
  }

  Future<void> _cadastrarFornecedor() async {
    print('');
    print('CADASTRO DE FORNECEDOR');

    final cnpj = InputUtils.lerTexto('CNPJ: ');
    final razaoSocial = InputUtils.lerTexto('Razao social: ');
    final nomeFantasia = InputUtils.lerTexto('Nome fantasia (opcional): ');
    final telefone = InputUtils.lerTexto('Telefone (opcional): ');
    final email = InputUtils.lerTexto('E-mail (opcional): ');
    final endereco = InputUtils.lerTexto('Endereco (opcional): ');

    await cadastroService.cadastrarFornecedor(
      usuario: usuario,
      cnpj: cnpj,
      razaoSocial: razaoSocial,
      nomeFantasia: nomeFantasia,
      telefone: telefone,
      email: email,
      endereco: endereco,
    );

    print('Fornecedor cadastrado com sucesso.');
  }

  Future<void> _cadastrarProduto() async {
    print('');
    print('CADASTRO DE PRODUTO');
    print('');
    print('Categorias disponiveis:');
    await _listarCategorias();

    final idCategoria = InputUtils.lerInt('ID da categoria: ');
    if (idCategoria == null) {
      throw ArgumentError('ID da categoria invalido.');
    }

    print('');
    print('Fornecedores disponiveis:');
    await _listarFornecedores();

    final idFornecedor = InputUtils.lerInt('ID do fornecedor: ');
    if (idFornecedor == null) {
      throw ArgumentError('ID do fornecedor invalido.');
    }

    final sku = InputUtils.lerTexto('SKU: ');
    final nome = InputUtils.lerTexto('Nome: ');
    final descricao = InputUtils.lerTexto('Descricao (opcional): ');
    final unidade = InputUtils.lerTexto('Unidade (kg, un, L etc.): ');

    final quantidade = InputUtils.lerDouble('Quantidade inicial: ');
    final minimo = InputUtils.lerDouble('Estoque minimo: ');
    final custo = InputUtils.lerDouble('Preco de custo: ');
    final venda = InputUtils.lerDouble('Preco de venda: ');

    if (quantidade == null ||
        minimo == null ||
        custo == null ||
        venda == null) {
      throw ArgumentError('Quantidade ou valor numerico invalido.');
    }

    await cadastroService.cadastrarProduto(
      usuario: usuario,
      sku: sku,
      nome: nome,
      descricao: descricao,
      unidadeMedida: unidade,
      quantidadeEstoque: quantidade,
      estoqueMinimo: minimo,
      precoCusto: custo,
      precoVenda: venda,
      idCategoria: idCategoria,
      idFornecedor: idFornecedor,
    );

    print('Produto cadastrado com sucesso.');
  }
}
