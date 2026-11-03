import '../exceptions/acesso_negado_exception.dart';
import '../models/usuario.dart';
import '../repositories/categoria_repository.dart';
import '../repositories/fornecedor_repository.dart';
import '../repositories/produto_repository.dart';

class CadastroService {
  final CategoriaRepository categoriaRepository;
  final FornecedorRepository fornecedorRepository;
  final ProdutoRepository produtoRepository;

  CadastroService({
    required this.categoriaRepository,
    required this.fornecedorRepository,
    required this.produtoRepository,
  });

  Future<void> cadastrarCategoria({
    required Usuario usuario,
    required String nome,
    String? descricao,
  }) async {
    _exigirPermissao(usuario, 'CADASTRAR_CATEGORIA');

    if (nome.trim().isEmpty) {
      throw ArgumentError('O nome da categoria e obrigatorio.');
    }

    await categoriaRepository.cadastrar(
      nome: nome.trim(),
      descricao: _vazioParaNull(descricao),
    );
  }

  Future<void> cadastrarFornecedor({
    required Usuario usuario,
    required String cnpj,
    required String razaoSocial,
    String? nomeFantasia,
    String? telefone,
    String? email,
    String? endereco,
  }) async {
    _exigirPermissao(usuario, 'CADASTRAR_FORNECEDOR');

    if (cnpj.trim().isEmpty || razaoSocial.trim().isEmpty) {
      throw ArgumentError('CNPJ e razao social sao obrigatorios.');
    }

    await fornecedorRepository.cadastrar(
      cnpj: cnpj.trim(),
      razaoSocial: razaoSocial.trim(),
      nomeFantasia: _vazioParaNull(nomeFantasia),
      telefone: _vazioParaNull(telefone),
      email: _vazioParaNull(email),
      endereco: _vazioParaNull(endereco),
    );
  }

  Future<void> cadastrarProduto({
    required Usuario usuario,
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
    _exigirPermissao(usuario, 'CADASTRAR_PRODUTO');

    if (sku.trim().isEmpty ||
        nome.trim().isEmpty ||
        unidadeMedida.trim().isEmpty) {
      throw ArgumentError('SKU, nome e unidade de medida sao obrigatorios.');
    }

    if (quantidadeEstoque < 0 ||
        estoqueMinimo < 0 ||
        precoCusto < 0 ||
        precoVenda < 0) {
      throw ArgumentError('Quantidades e valores nao podem ser negativos.');
    }

    if (!await categoriaRepository.existe(idCategoria)) {
      throw ArgumentError('Categoria informada nao existe ou esta inativa.');
    }

    if (!await fornecedorRepository.existe(idFornecedor)) {
      throw ArgumentError('Fornecedor informado nao existe ou esta inativo.');
    }

    await produtoRepository.cadastrar(
      sku: sku.trim(),
      nome: nome.trim(),
      descricao: _vazioParaNull(descricao),
      unidadeMedida: unidadeMedida.trim(),
      quantidadeEstoque: quantidadeEstoque,
      estoqueMinimo: estoqueMinimo,
      precoCusto: precoCusto,
      precoVenda: precoVenda,
      idCategoria: idCategoria,
      idFornecedor: idFornecedor,
    );
  }

  void _exigirPermissao(Usuario usuario, String permissao) {
    if (!usuario.ativo || !usuario.pode(permissao)) {
      throw AcessoNegadoException(
        'O perfil ${usuario.perfil} nao possui a permissao $permissao.',
      );
    }
  }

  String? _vazioParaNull(String? valor) {
    final texto = valor?.trim() ?? '';
    return texto.isEmpty ? null : texto;
  }
}
