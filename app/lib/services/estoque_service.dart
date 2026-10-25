import '../models/movimentacao.dart';

class EstoqueService {
  final List<Movimentacao> _historico = [];

  List<Movimentacao> get historico => List.unmodifiable(_historico);

  void registrarMovimentacao(Movimentacao movimentacao) {
    movimentacao.aplicar();
    _historico.add(movimentacao);
  }

  int get totalMovimentacoes => _historico.length;
}
