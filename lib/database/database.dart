import 'package:path/path.dart';
import 'package:quantum/filesystem/path.dart';

class QMSqliteClient {
  // late Database _database;

  // 连接到指定数据库，仅支持指定数据库名称
  static Future<QMSqliteClient?> connect(
    String appDbPath, {
    String initSql = '',
  }) async {
    var fullDbPath =
        await prepareAppWorkDir(join("databases", dirname(appDbPath)));
    print("databasesPath: $fullDbPath");
    if (fullDbPath == null) {
      return null;
    }
    fullDbPath = join(fullDbPath, basename(appDbPath));
    print("databasesPath2: $fullDbPath");

    // var database = sqlite3.open(fullDbPath, mode: OpenMode.readWrite);
    // if (initSql.isNotEmpty) {
    //   database.execute(initSql, []);
    // }

    var helper = QMSqliteClient();
    // helper._database = database;

    return helper;
  }

  void close() {
    // _database.dispose();
  }

  static Future<QMSqliteClient> connectInMemory() async {
    // Database database = sqlite3.openInMemory();

    var helper = QMSqliteClient();
    // helper._database = database;

    return helper;
  }

  Future<void> executeAsync(String sql,
      [List<Object?> parameters = const []]) async {
    // _database.execute(sql, parameters);
  }

  Future<List<Map<String, Object?>>> selectAsync(String sql,
      [List<Object?> parameters = const []]) async {
    // var resultSet = _database.select(sql, parameters);
    // return resultSet.map((row) => row).toList();
    return [];
  }
}
