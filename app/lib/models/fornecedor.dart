class Fornecedor {
  final int id;
  final String cnpj;
  String razaoSocial;
  String? nomeFantasia;
  String? telefone;
  String? email;
  String? endereco;
  bool ativo;

  Fornecedor({
    required this.id,
    required this.cnpj,
    required this.razaoSocial,
    this.nomeFantasia,
    this.telefone,
    this.email,
    this.endereco,
    this.ativo = true,
  });

  String get nomeExibicao => nomeFantasia ?? razaoSocial;

  @override
  String toString() => nomeExibicao;
}
