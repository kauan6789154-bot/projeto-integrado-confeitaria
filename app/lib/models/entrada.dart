import 'movimentacao.dart';

class Entrada extends Movimentacao {
  Entrada({
    required super.id,
    required super.quantidade,
    required super.motivo,
    super.observacao,
    required super.dataHora,
    required super.produto,
    required super.usuario,
  });

  @override
  String get tipo => 'ENTRADA';

  @override
  void aplicar() {
    produto.adicionarEstoque(quantidade);
  }
}
