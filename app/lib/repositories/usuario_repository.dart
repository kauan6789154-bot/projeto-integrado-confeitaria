import 'package:mysql_client_plus/mysql_client_plus.dart';

import '../models/administrador.dart';
import '../models/operador.dart';
import '../models/usuario.dart';

class UsuarioRepository {
  final MySQLConnection connection;

  UsuarioRepository(this.connection);

  Future<Usuario?> autenticar({
    required String email,
    required String senha,
  }) async {
    final resultado = await connection.execute(
      '''
      SELECT id_usuario, nome, email, perfil, ativo
      FROM usuario
      WHERE email = :email
        AND senha_hash = SHA2(:senha, 256)
        AND ativo = TRUE
      LIMIT 1
      ''',
      {'email': email, 'senha': senha},
    );

    if (resultado.rows.isEmpty) return null;

    final row = resultado.rows.first;
    final id = int.parse(row.colByName('id_usuario')!);
    final nome = row.colByName('nome')!;
    final emailBanco = row.colByName('email')!;
    final perfil = row.colByName('perfil')!;

    if (perfil == 'ADMINISTRADOR') {
      return Administrador(id: id, nome: nome, email: emailBanco);
    }

    if (perfil == 'OPERADOR') {
      return Operador(id: id, nome: nome, email: emailBanco);
    }

    throw StateError('Perfil desconhecido: $perfil');
  }
}
