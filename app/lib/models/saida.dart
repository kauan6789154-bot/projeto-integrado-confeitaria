import 'movimentacao.dart';

class Saida extends Movimentacao {
  Saida({
    required super.id,
    required super.quantidade,
    required super.motivo,
    super.observacao,
    required super.dataHora,
    required super.produto,
    required super.usuario,
  });

  @override
  String get tipo => 'SAIDA';

  @override
  void aplicar() {
    produto.removerEstoque(quantidade);
  }
}
