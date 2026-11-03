import '../exceptions/acesso_negado_exception.dart';
import '../exceptions/quantidade_invalida_exception.dart';
import '../models/usuario.dart';
import '../repositories/movimentacao_repository.dart';

class MovimentacaoService {
  final MovimentacaoRepository movimentacaoRepository;

  MovimentacaoService(this.movimentacaoRepository);

  Future<double> registrarEntrada({
    required Usuario usuario,
    required int idProduto,
    required double quantidade,
    required String motivo,
    String? observacao,
  }) async {
    _exigirPermissao(usuario, 'REGISTRAR_ENTRADA');
    _validar(quantidade, motivo);

    return movimentacaoRepository.registrarEntrada(
      idProduto: idProduto,
      quantidade: quantidade,
      motivo: motivo.trim(),
      observacao: _vazioParaNull(observacao),
      idUsuario: usuario.id,
    );
  }

  Future<double> registrarSaida({
    required Usuario usuario,
    required int idProduto,
    required double quantidade,
    required String motivo,
    String? observacao,
  }) async {
    _exigirPermissao(usuario, 'REGISTRAR_SAIDA');
    _validar(quantidade, motivo);

    return movimentacaoRepository.registrarSaida(
      idProduto: idProduto,
      quantidade: quantidade,
      motivo: motivo.trim(),
      observacao: _vazioParaNull(observacao),
      idUsuario: usuario.id,
    );
  }

  void _validar(double quantidade, String motivo) {
    if (quantidade <= 0) {
      throw QuantidadeInvalidaException(
        'A quantidade deve ser maior que zero.',
      );
    }

    if (motivo.trim().isEmpty) {
      throw ArgumentError('O motivo da movimentacao e obrigatorio.');
    }
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
