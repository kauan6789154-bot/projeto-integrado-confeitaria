import 'usuario.dart';

class Operador extends Usuario {
  Operador({
    required super.id,
    required super.nome,
    required super.email,
    super.ativo,
  });

  @override
  String get perfil => 'OPERADOR';

  @override
  List<String> get permissoes => const [
        'REGISTRAR_ENTRADA',
        'REGISTRAR_SAIDA',
        'CONSULTAR_ESTOQUE',
        'CONSULTAR_HISTORICO',
      ];
}
