import '../exceptions/acesso_negado_exception.dart';
import '../models/usuario.dart';
import '../repositories/consulta_repository.dart';

class ConsultaService {
  final ConsultaRepository consultaRepository;

  ConsultaService(this.consultaRepository);

  Future<dynamic> listarProdutosCriticos(Usuario usuario) {
    _exigirPermissao(usuario, 'CONSULTAR_ESTOQUE');
    return consultaRepository.listarProdutosCriticos();
  }

  Future<dynamic> listarHistorico(
    Usuario usuario, {
    int limite = 30,
  }) {
    _exigirPermissao(usuario, 'CONSULTAR_HISTORICO');

    if (limite <= 0 || limite > 100) {
      throw ArgumentError(
        'O limite do historico deve estar entre 1 e 100.',
      );
    }

    return consultaRepository.listarHistorico(
      limite: limite,
    );
  }

  void _exigirPermissao(
    Usuario usuario,
    String permissao,
  ) {
    if (!usuario.ativo || !usuario.pode(permissao)) {
      throw AcessoNegadoException(
        'O perfil ${usuario.perfil} nao possui a permissao $permissao.',
      );
    }
  }
}
