import 'package:confeitaria_estoque/models/administrador.dart';
import 'package:confeitaria_estoque/models/operador.dart';
import 'package:test/test.dart';

void main() {
  group('Controle de acesso', () {
    test('administrador possui permissoes administrativas', () {
      final admin = Administrador(
        id: 1,
        nome: 'Admin',
        email: 'admin@teste.local',
      );

      expect(admin.pode('CONSULTAR_ESTOQUE'), isTrue);
      expect(admin.pode('CADASTRAR_PRODUTO'), isTrue);
      expect(admin.pode('GERENCIAR_USUARIOS'), isTrue);
    });

    test('operador possui permissoes operacionais', () {
      final operador = Operador(
        id: 2,
        nome: 'Operador',
        email: 'operador@teste.local',
      );

      expect(operador.pode('CONSULTAR_ESTOQUE'), isTrue);
      expect(operador.pode('REGISTRAR_ENTRADA'), isTrue);
      expect(operador.pode('REGISTRAR_SAIDA'), isTrue);
    });

    test('operador nao possui permissoes administrativas', () {
      final operador = Operador(
        id: 2,
        nome: 'Operador',
        email: 'operador@teste.local',
      );

      expect(operador.pode('CADASTRAR_PRODUTO'), isFalse);
      expect(operador.pode('GERENCIAR_USUARIOS'), isFalse);
    });
  });
}
