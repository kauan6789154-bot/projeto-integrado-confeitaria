class EstoqueInsuficienteException implements Exception {
  final String mensagem;

  EstoqueInsuficienteException(this.mensagem);

  @override
  String toString() => 'EstoqueInsuficienteException: $mensagem';
}
