class AcessoNegadoException implements Exception {
  final String mensagem;

  AcessoNegadoException(this.mensagem);

  @override
  String toString() => 'AcessoNegadoException: $mensagem';
}
