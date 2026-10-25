class Console {
  static void linha() {
    print('==============================================');
  }

  static void exibirCabecalho(String nomeSistema, String versao) {
    linha();
    print(nomeSistema.toUpperCase());
    print('Versao: $versao');
    linha();
  }

  static void exibirMensagemInicial() {
    print('');
    print('Estrutura inicial da aplicacao Dart configurada com sucesso.');
    print('');
    print('Nesta etapa ainda nao existem cadastros, login ou banco conectado.');
    print('Essas funcionalidades serao implementadas nas proximas partes.');
    print('');
  }
}
