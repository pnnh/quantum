import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:path/path.dart';
import 'package:quantum/bindings.dart';
import 'package:quantum/filesystem/path.dart';
import 'package:quantum/generated_bindings.dart';

// 测试包装的sqlite3查询语句
Future sqliteSelectNames() async {
  var quantumFFI = FFIBindings();
  var dbPath = "quantum.sqlite";
  var qkStr = quantumFFI.quantumNative
      .QKStringCreate(dbPath.toNativeUtf8() as ffi.Pointer<ffi.Char>);
  var sqlSvc = quantumFFI.quantumNative.QKSqliteServiceCreate(qkStr);

  var selectText = "SELECT 'hello呀哈哈' as strVal, 128 as intVal;";
  var qkSelectText = quantumFFI.quantumNative
      .QKStringCreate(selectText.toNativeUtf8() as ffi.Pointer<ffi.Char>);
  var sqlResult = quantumFFI.quantumNative.QKSqliteRunSql(sqlSvc, qkSelectText);
  var sqlRow = quantumFFI.quantumNative.QKSqliteResultGetRow(sqlResult, 0);
  var strColName = quantumFFI.quantumNative
      .QKStringCreate("strVal".toNativeUtf8() as ffi.Pointer<ffi.Char>);
  var strCol =
      quantumFFI.quantumNative.QKSqliteRowGetColumnByName(sqlRow, strColName);
  var qkStrValStr =
      quantumFFI.quantumNative.QKSQliteColumnGetStringValue(strCol);
  var dartStr = quantumFFI.quantumNative
      .QKStringGetData(qkStrValStr)
      .cast<Utf8>()
      .toDartString();
  print("strVal: $dartStr");
  var intColName = quantumFFI.quantumNative
      .QKStringCreate("intVal".toNativeUtf8() as ffi.Pointer<ffi.Char>);
  var intCol =
      quantumFFI.quantumNative.QKSqliteRowGetColumnByName(sqlRow, intColName);
  var intValInt = quantumFFI.quantumNative.QKSQliteColumnGetIntValue(intCol);
  print("intVal: $intValInt");
}

class QMSqliteClient {
  late ffi.Pointer<QKSqliteService> sqlSvc;
  late FFIBindings quantumFFI;

  static Future<String?> sqliteVersion() async {
    var quantumFFI = FFIBindings();
    var dbPath = "quantum.sqlite";
    var qkStr = quantumFFI.quantumNative
        .QKStringCreate(dbPath.toNativeUtf8() as ffi.Pointer<ffi.Char>);

    var sqlSvc = quantumFFI.quantumNative.QKSqliteServiceCreate(qkStr);
    var qkVersion = quantumFFI.quantumNative.QKSqliteVersion(sqlSvc);
    var qkChar = quantumFFI.quantumNative.QKStringGetData(qkVersion);
    var versionStr = qkChar.cast<Utf8>().toDartString();
    //var versionStr = qkVersion.ref.data.cast<Utf8>().toDartString();
    quantumFFI.quantumNative.QKSqliteServiceDelete(sqlSvc);
    return versionStr;
  }

  QMSqliteClient(String fullDbPath) {
    quantumFFI = FFIBindings();

    var qkStr = quantumFFI.quantumNative
        .QKStringCreate(fullDbPath.toNativeUtf8() as ffi.Pointer<ffi.Char>);

    var sqlSvc = quantumFFI.quantumNative.QKSqliteServiceCreate(qkStr);
    this.sqlSvc = sqlSvc;
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

    var client = QMSqliteClient(fullDbPath);

    return client;
  }

  void close() {
    quantumFFI.quantumNative.QKSqliteServiceDelete(sqlSvc);
  }

  Future<List<Map<String, Object?>>> executeAsync(String sqlText,
      [List<Object?> parameters = const []]) async {
    var result = <Map<String, Object?>>[];

    var qkSqlText = quantumFFI.quantumNative
        .QKStringCreate(sqlText.toNativeUtf8() as ffi.Pointer<ffi.Char>);
    var sqlResult = quantumFFI.quantumNative.QKSqliteRunSql(sqlSvc, qkSqlText);
    var rowCount =
        quantumFFI.quantumNative.QKSqliteResultGetRowCount(sqlResult);
    if (rowCount == 0) {
      return [];
    }

    for (var rowIndex = 0; rowIndex < rowCount; rowIndex++) {
      var sqlRow =
          quantumFFI.quantumNative.QKSqliteResultGetRow(sqlResult, rowIndex);
      var colCount = quantumFFI.quantumNative.QKSqliteRowGetColumnCount(sqlRow);
      var colObj = <String, Object?>{};
      for (var colIndex = 0; colIndex < colCount; colIndex++) {
        var qkCol = quantumFFI.quantumNative
            .QKSqliteRowGetColumnByIndex(sqlRow, colIndex);
        var colName = quantumFFI.quantumNative.QKSQliteColumnGetName(qkCol);

        var qkColType =
            quantumFFI.quantumNative.QKSQliteColumnGetValueType(qkCol);
        if (qkColType == quantumFFI.quantumNative.QKSqliteValueString) {
          var qkStrVal =
              quantumFFI.quantumNative.QKSQliteColumnGetStringValue(qkCol);
          var dartStr = quantumFFI.quantumNative
              .QKStringGetData(qkStrVal)
              .cast<Utf8>()
              .toDartString();
          print("strVal: $dartStr");
          colObj[colName.cast<Utf8>().toDartString()] = dartStr;
        } else if (qkColType == quantumFFI.quantumNative.QKSqliteValueInt) {
          var intValInt =
              quantumFFI.quantumNative.QKSQliteColumnGetIntValue(qkCol);
          print("intVal: $intValInt");
          colObj[colName.cast<Utf8>().toDartString()] = intValInt;
        } else {
          print("unknown type");
        }
      }
      result.add(colObj);
    }

    return result;
  }
}
