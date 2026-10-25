import 'produto.dart';
import 'usuario.dart';

abstract class Movimentacao {
  final int id;
  final double quantidade;
  final String motivo;
  final String? observacao;
  final DateTime dataHora;
  final Produto produto;
  final Usuario usuario;

  Movimentacao({
    required this.id,
    required this.quantidade,
    required this.motivo,
    this.observacao,
    required this.dataHora,
    required this.produto,
    required this.usuario,
  });

  String get tipo;

  void aplicar();

  String descricao() {
    return '$tipo | ${produto.nome} | '
        '${quantidade.toStringAsFixed(3)} ${produto.unidadeMedida} | '
        'Usuario: ${usuario.nome}';
  }
}
