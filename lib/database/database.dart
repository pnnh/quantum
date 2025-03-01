import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:path/path.dart';
import 'package:quantum/bindings.dart';
import 'package:quantum/filesystem/path.dart';

class QMSqliteClient {
  // late Database _database;

  static Future<String?> sqliteVersion() async {
    var quantumFFI = FFIBindings();
    var dbPath = "quantum.sqlite";
    var qkStr = quantumFFI.quantumNative.QKStringCreate(
        dbPath.toNativeUtf8() as ffi.Pointer<ffi.Char>, dbPath.length);

    var sqlSvc = quantumFFI.quantumNative.QKSqliteServiceCreate(qkStr);
    var version = quantumFFI.quantumNative.QKSqliteVersion(sqlSvc);
    var versionStr = version.ref.data.cast<Utf8>().toDartString();
    quantumFFI.quantumNative.QKSqliteServiceDelete(sqlSvc);
    return versionStr;
  }

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
