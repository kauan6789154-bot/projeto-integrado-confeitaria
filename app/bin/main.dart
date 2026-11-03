import 'package:confeitaria_estoque/config/app_config.dart';
import 'package:confeitaria_estoque/config/database_config.dart';
import 'package:confeitaria_estoque/config/database_connection.dart';
import 'package:confeitaria_estoque/models/usuario.dart';
import 'package:confeitaria_estoque/repositories/categoria_repository.dart';
import 'package:confeitaria_estoque/repositories/fornecedor_repository.dart';
import 'package:confeitaria_estoque/repositories/produto_repository.dart';
import 'package:confeitaria_estoque/repositories/usuario_repository.dart';
import 'package:confeitaria_estoque/services/auth_service.dart';
import 'package:confeitaria_estoque/services/cadastro_service.dart';
import 'package:confeitaria_estoque/utils/console.dart';
import 'package:confeitaria_estoque/utils/input_utils.dart';
import 'package:confeitaria_estoque/utils/menu_principal.dart';

Future<void> main() async {
  Console.exibirCabecalho(AppConfig.nomeSistema, AppConfig.versao);

  DatabaseConnection? database;

  try {
    final config = DatabaseConfig.carregar();
    database = DatabaseConnection(config);
    final connection = await database.abrir();

    final usuarioRepository = UsuarioRepository(connection);
    final authService = AuthService(usuarioRepository);

    final usuario = await _realizarLogin(authService);

    if (usuario == null) {
      print('');
      print('Numero maximo de tentativas atingido.');
      return;
    }

    print('');
    print('Login realizado com sucesso.');
    print('Usuario: ${usuario.nome}');
    print('Perfil: ${usuario.perfil}');

    final categoriaRepository = CategoriaRepository(connection);
    final fornecedorRepository = FornecedorRepository(connection);
    final produtoRepository = ProdutoRepository(connection);

    final cadastroService = CadastroService(
      categoriaRepository: categoriaRepository,
      fornecedorRepository: fornecedorRepository,
      produtoRepository: produtoRepository,
    );

    final menu = MenuPrincipal(
      usuario: usuario,
      cadastroService: cadastroService,
      categoriaRepository: categoriaRepository,
      fornecedorRepository: fornecedorRepository,
      produtoRepository: produtoRepository,
    );

    await menu.executar();
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

    final usuario = await authService.login(
      email: email,
      senha: senha,
    );

    if (usuario != null) {
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
