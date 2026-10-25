import 'package:confeitaria_estoque/config/app_config.dart';
import 'package:confeitaria_estoque/utils/console.dart';

void main() {
  Console.exibirCabecalho(
    AppConfig.nomeSistema,
    AppConfig.versao,
  );

  Console.exibirMensagemInicial();
}
