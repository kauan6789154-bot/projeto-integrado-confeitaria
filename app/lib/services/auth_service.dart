import '../models/usuario.dart';
import '../repositories/usuario_repository.dart';

class AuthService {
  final UsuarioRepository usuarioRepository;

  AuthService(this.usuarioRepository);

  Future<Usuario?> login({
    required String email,
    required String senha,
  }) {
    return usuarioRepository.autenticar(
      email: email.trim().toLowerCase(),
      senha: senha,
    );
  }

  bool possuiPermissao(Usuario usuario, String permissao) {
    return usuario.ativo && usuario.pode(permissao);
  }
}
