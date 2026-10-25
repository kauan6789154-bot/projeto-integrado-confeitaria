class QuantidadeInvalidaException implements Exception {
  final String mensagem;

  QuantidadeInvalidaException(this.mensagem);

  @override
  String toString() => 'QuantidadeInvalidaException: $mensagem';
}
