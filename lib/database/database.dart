import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class QMSqliteClient {
  late Database _database;

  // 连接到指定数据库，仅支持指定数据库名称
  static Future<QMSqliteClient> connect(
    String dbName, {
    String initSql = '',
  }) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var databasesPath = appDocDir.path;
    debugPrint("databasesPath: $databasesPath");
    String fullDbPath = join(databasesPath, dbName);

    Database database = await openDatabase(fullDbPath, version: 1,
        onCreate: (Database db, int version) async {
      if (initSql.isNotEmpty) {
        await db.execute(initSql);
      }
    });

    var helper = QMSqliteClient();
    helper._database = database;

    return helper;
  }

  void close() {
    _database.close();
  }

  static Future<QMSqliteClient> connectInMemory() async {
    Database database = await openDatabase(inMemoryDatabasePath);

    var helper = QMSqliteClient();
    helper._database = database;

    return helper;
  }

  Future<dynamic> databaseInsert(String sqlText, List params) async {
    var result = await _database.rawInsert(sqlText, params);
    return result;
  }

  Future<void> executeAsync(String sql,
      [List<Object?> parameters = const []]) async {
    _database.execute(sql, parameters);
  }

  Future<List<Map<String, Object?>>> selectAsync(String sql,
      [List<Object?> parameters = const []]) async {
    return _database.rawQuery(sql, parameters);
  }

  Future<void> transactionAsync(Map<String, List<Object?>> commands) async {
    await _database.transaction((txn) async {
      for (var command in commands.entries) {
        await txn.execute(command.key, command.value);
      }
    });
  }
}
