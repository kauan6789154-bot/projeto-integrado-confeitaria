import '../models/usuario.dart';
import '../repositories/categoria_repository.dart';
import '../repositories/fornecedor_repository.dart';
import '../repositories/produto_repository.dart';
import '../services/cadastro_service.dart';
import '../services/consulta_service.dart';
import '../services/movimentacao_service.dart';
import 'console.dart';
import 'input_utils.dart';

class MenuPrincipal {
  final Usuario usuario;
  final CadastroService cadastroService;
  final MovimentacaoService movimentacaoService;
  final ConsultaService consultaService;
  final CategoriaRepository categoriaRepository;
  final FornecedorRepository fornecedorRepository;
  final ProdutoRepository produtoRepository;

  MenuPrincipal({
    required this.usuario,
    required this.cadastroService,
    required this.movimentacaoService,
    required this.consultaService,
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
      print('2 - Produtos abaixo do estoque minimo');
      print('3 - Historico de movimentacoes');
      print('4 - Listar categorias');
      print('5 - Listar fornecedores');
      print('6 - Registrar entrada de estoque');
      print('7 - Registrar saida de estoque');
      print('8 - Cadastrar categoria');
      print('9 - Cadastrar fornecedor');
      print('10 - Cadastrar produto');
      print('11 - Remover produto');
      print('12 - Remover categoria');
      print('13 - Remover fornecedor');
      print('0 - Sair');

      final opcao = InputUtils.lerTexto('Opcao: ');

      try {
        switch (opcao) {
          case '1':
            await _listarProdutos();
            break;
          case '2':
            await _listarProdutosCriticos();
            break;
          case '3':
            await _listarHistorico();
            break;
          case '4':
            await _listarCategorias();
            break;
          case '5':
            await _listarFornecedores();
            break;
          case '6':
            await _registrarEntrada();
            break;
          case '7':
            await _registrarSaida();
            break;
          case '8':
            await _cadastrarCategoria();
            break;
          case '9':
            await _cadastrarFornecedor();
            break;
          case '10':
            await _cadastrarProduto();
            break;
          case '11':
            await _removerProduto();
            break;
          case '12':
            await _removerCategoria();
            break;
          case '13':
            await _removerFornecedor();
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

  Future<void> _listarProdutosCriticos() async {
    final resultado = await consultaService.listarProdutosCriticos(
      usuario,
    );

    print('');
    print('ALERTA DE ESTOQUE MINIMO');
    print('----------------------------------------------');

    if (resultado.rows.isEmpty) {
      print('Nenhum produto esta abaixo ou no estoque minimo.');
    } else {
      for (final row in resultado.rows) {
        final estoque = double.parse(
          row.colByName('quantidade_estoque')!,
        );
        final minimo = double.parse(
          row.colByName('estoque_minimo')!,
        );
        final unidade = row.colByName('unidade_medida')!;

        print(
          '${row.colByName('id_produto')} | '
          '${row.colByName('sku')} | '
          '${row.colByName('nome')} | '
          'Estoque: ${estoque.toStringAsFixed(3)} $unidade | '
          'Minimo: ${minimo.toStringAsFixed(3)} $unidade | '
          'REPOSICAO NECESSARIA',
        );
      }
    }

    print('----------------------------------------------');
    print('Total de produtos criticos: ${resultado.numOfRows}');
  }

  Future<void> _listarHistorico() async {
    print('');
    print('HISTORICO DE MOVIMENTACOES');

    final limiteInformado = InputUtils.lerTexto(
      'Quantidade de registros [Enter = 30]: ',
    );

    var limite = 30;

    if (limiteInformado.isNotEmpty) {
      final convertido = int.tryParse(limiteInformado);

      if (convertido == null) {
        throw ArgumentError('Quantidade de registros invalida.');
      }

      limite = convertido;
    }

    final resultado = await consultaService.listarHistorico(
      usuario,
      limite: limite,
    );

    print('');
    print('ULTIMAS MOVIMENTACOES');
    print('----------------------------------------------');

    if (resultado.rows.isEmpty) {
      print('Nenhuma movimentacao registrada.');
    } else {
      for (final row in resultado.rows) {
        final observacao = row.colByName('observacao');
        final obsTexto = (observacao == null || observacao.isEmpty)
            ? ''
            : ' | Obs: $observacao';

        print(
          '#${row.colByName('id_movimentacao')} | '
          '${row.colByName('data_hora')} | '
          '${row.colByName('tipo')} | '
          '${row.colByName('produto')} | '
          '${row.colByName('quantidade')} '
          '${row.colByName('unidade_medida')} | '
          'Motivo: ${row.colByName('motivo')} | '
          'Usuario: ${row.colByName('usuario')} '
          '(${row.colByName('perfil')})'
          '$obsTexto',
        );
      }
    }

    print('----------------------------------------------');
    print('Registros exibidos: ${resultado.numOfRows}');
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

  Future<void> _removerProduto() async {
    print('');
    print('REMOVER PRODUTO');
    await _listarProdutos();

    final idProduto = InputUtils.lerInt('ID do produto: ');

    if (idProduto == null) {
      throw ArgumentError('ID do produto invalido.');
    }

    final confirmacao = InputUtils.lerTexto(
      'Confirma a remocao do produto $idProduto? (S/N): ',
    );

    if (confirmacao.toUpperCase() != 'S') {
      print('Remocao cancelada.');
      return;
    }

    await cadastroService.removerProduto(
      usuario: usuario,
      idProduto: idProduto,
    );

    print('Produto removido com sucesso.');
  }

  Future<void> _removerCategoria() async {
    print('');
    print('REMOVER CATEGORIA');
    await _listarCategorias();

    final idCategoria = InputUtils.lerInt('ID da categoria: ');

    if (idCategoria == null) {
      throw ArgumentError('ID da categoria invalido.');
    }

    final confirmacao = InputUtils.lerTexto(
      'Confirma a remocao da categoria $idCategoria? (S/N): ',
    );

    if (confirmacao.toUpperCase() != 'S') {
      print('Remocao cancelada.');
      return;
    }

    await cadastroService.removerCategoria(
      usuario: usuario,
      idCategoria: idCategoria,
    );

    print('Categoria removida com sucesso.');
  }

  Future<void> _removerFornecedor() async {
    print('');
    print('REMOVER FORNECEDOR');
    await _listarFornecedores();

    final idFornecedor = InputUtils.lerInt('ID do fornecedor: ');

    if (idFornecedor == null) {
      throw ArgumentError('ID do fornecedor invalido.');
    }

    final confirmacao = InputUtils.lerTexto(
      'Confirma a remocao do fornecedor $idFornecedor? (S/N): ',
    );

    if (confirmacao.toUpperCase() != 'S') {
      print('Remocao cancelada.');
      return;
    }

    await cadastroService.removerFornecedor(
      usuario: usuario,
      idFornecedor: idFornecedor,
    );

    print('Fornecedor removido com sucesso.');
  }


}
