import 'dart:io';

class InputUtils {
  static String lerTexto(String mensagem) {
    stdout.write(mensagem);
    return stdin.readLineSync()?.trim() ?? '';
  }

  static String lerSenha(String mensagem) {
    stdout.write(mensagem);

    if (!stdin.hasTerminal) {
      return stdin.readLineSync() ?? '';
    }

    final echoAnterior = stdin.echoMode;

    try {
      stdin.echoMode = false;
      final senha = stdin.readLineSync() ?? '';
      stdout.writeln();
      return senha;
    } finally {
      stdin.echoMode = echoAnterior;
    }
  }

  static int? lerInt(String mensagem) {
    final valor = lerTexto(mensagem);
    return int.tryParse(valor);
  }

  static double? lerDouble(String mensagem) {
    final valor = lerTexto(mensagem).replaceAll(',', '.');
    return double.tryParse(valor);
  }
}
