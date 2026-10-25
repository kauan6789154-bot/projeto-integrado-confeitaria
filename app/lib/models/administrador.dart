import 'usuario.dart';

class Administrador extends Usuario {
  Administrador({
    required super.id,
    required super.nome,
    required super.email,
    super.ativo,
  });

  @override
  String get perfil => 'ADMINISTRADOR';

  @override
  List<String> get permissoes => const [
        'CADASTRAR_CATEGORIA',
        'CADASTRAR_FORNECEDOR',
        'CADASTRAR_PRODUTO',
        'REGISTRAR_ENTRADA',
        'REGISTRAR_SAIDA',
        'CONSULTAR_ESTOQUE',
        'CONSULTAR_HISTORICO',
        'GERENCIAR_USUARIOS',
      ];
}
