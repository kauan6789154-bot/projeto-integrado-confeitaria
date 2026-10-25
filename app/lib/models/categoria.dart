class Categoria {
  final int id;
  String nome;
  String? descricao;
  bool ativo;

  Categoria({
    required this.id,
    required this.nome,
    this.descricao,
    this.ativo = true,
  });

  @override
  String toString() => nome;
}
