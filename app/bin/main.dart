import 'package:confeitaria_estoque/config/app_config.dart';
import 'package:confeitaria_estoque/config/database_config.dart';
import 'package:confeitaria_estoque/config/database_connection.dart';
import 'package:confeitaria_estoque/models/usuario.dart';
import 'package:confeitaria_estoque/repositories/usuario_repository.dart';
import 'package:confeitaria_estoque/services/auth_service.dart';
import 'package:confeitaria_estoque/utils/console.dart';
import 'package:confeitaria_estoque/utils/input_utils.dart';

Future<void> main() async {
  Console.exibirCabecalho(AppConfig.nomeSistema, AppConfig.versao);

  DatabaseConnection? database;

  try {
    final config = DatabaseConfig.carregar();
    database = DatabaseConnection(config);
    final connection = await database.abrir();

    final authService = AuthService(UsuarioRepository(connection));
    final usuario = await _realizarLogin(authService);

    if (usuario == null) {
      print('');
      print('Numero maximo de tentativas atingido.');
      return;
    }

    _exibirSessao(usuario);
    _menuAcesso(usuario, authService);
  } catch (erro) {
    print('');
    print('Nao foi possivel iniciar o sistema.');
    print('Detalhes: $erro');
  } finally {
    await database?.fechar();
  }
}

Future<Usuario?> _realizarLogin(AuthService authService) async {
  const maxTentativas = 3;

  for (var tentativa = 1; tentativa <= maxTentativas; tentativa++) {
    print('');
    print('============== LOGIN ==============');

    final email = InputUtils.lerTexto('E-mail: ');
    final senha = InputUtils.lerSenha('Senha: ');

    final usuario = await authService.login(email: email, senha: senha);

    if (usuario != null) {
      print('');
      print('Login realizado com sucesso.');
      return usuario;
    }

    final restantes = maxTentativas - tentativa;
    print('');
    print('E-mail ou senha invalidos.');

    if (restantes > 0) {
      print('Tentativas restantes: $restantes');
    }
  }

  return null;
}

void _exibirSessao(Usuario usuario) {
  print('');
  Console.linha();
  print('USUARIO AUTENTICADO');
  Console.linha();
  print('Nome: ${usuario.nome}');
  print('E-mail: ${usuario.email}');
  print('Perfil: ${usuario.perfil}');
  print('');
  print('Permissoes:');

  for (final permissao in usuario.permissoes) {
    print('- $permissao');
  }
}

void _menuAcesso(Usuario usuario, AuthService authService) {
  while (true) {
    print('');
    Console.linha();
    print('MENU DE VALIDACAO DE ACESSO');
    Console.linha();
    print('1 - Consultar estoque');
    print('2 - Registrar saida');
    print('3 - Cadastrar produto');
    print('4 - Gerenciar usuarios');
    print('0 - Sair');

    final opcao = InputUtils.lerTexto('Opcao: ');

    switch (opcao) {
      case '1':
        _validar(usuario, authService, 'CONSULTAR_ESTOQUE', 'Consultar estoque');
        break;
      case '2':
        _validar(usuario, authService, 'REGISTRAR_SAIDA', 'Registrar saida');
        break;
      case '3':
        _validar(usuario, authService, 'CADASTRAR_PRODUTO', 'Cadastrar produto');
        break;
      case '4':
        _validar(usuario, authService, 'GERENCIAR_USUARIOS', 'Gerenciar usuarios');
        break;
      case '0':
        print('');
        print('Sessao encerrada.');
        return;
      default:
        print('');
        print('Opcao invalida.');
    }
  }
}

void _validar(
  Usuario usuario,
  AuthService authService,
  String permissao,
  String acao,
) {
  print('');

  if (authService.possuiPermissao(usuario, permissao)) {
    print('ACESSO PERMITIDO: $acao.');
  } else {
    print('ACESSO NEGADO: seu perfil nao possui permissao para "$acao".');
  }
}
