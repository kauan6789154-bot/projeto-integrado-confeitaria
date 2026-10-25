abstract class Usuario {
  final int id;
  String nome;
  String email;
  bool ativo;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    this.ativo = true,
  });

  String get perfil;

  List<String> get permissoes;

  bool pode(String permissao) => permissoes.contains(permissao);

  String resumo() => '$nome - $perfil';
}
