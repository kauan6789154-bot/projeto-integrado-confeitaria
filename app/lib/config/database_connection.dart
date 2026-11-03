import 'package:mysql_client_plus/mysql_client_plus.dart';

import 'database_config.dart';

class DatabaseConnection {
  final DatabaseConfig config;
  MySQLConnection? _connection;

  DatabaseConnection(this.config);

  Future<MySQLConnection> abrir() async {
    final connection = await MySQLConnection.createConnection(
      host: config.host,
      port: config.port,
      userName: config.user,
      password: config.password,
      databaseName: config.database,
      secure: true,
    );

    await connection.connect();
    _connection = connection;

    return connection;
  }

  Future<void> fechar() async {
    final connection = _connection;

    if (connection != null) {
      await connection.close();
      _connection = null;
    }
  }
}
