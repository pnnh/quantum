import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:quantum/filesystem/path.dart';
import 'package:quantum/filesystem/storage.dart';
import 'package:quantum/messages.g.dart';
import 'package:quantum/utils/md5.dart';
import 'package:quantum/utils/string.dart';
import 'package:uuid/uuid.dart';

part 'file.g.dart';

@JsonSerializable()
class QMFileModel {
  String uid;
  String name;
  String path;
  int count = 0;
  bool isFolder = false;

  QMFileModel(this.uid, {required this.path, this.name = "测试文件"});

  bool get isHidden {
    return name.startsWith(".");
  }

  String get fileMime {
    if (isFolder) {
      return "";
    }
    return lookupMimeType(path) ?? "unknown";
  }

  String get fileExtension {
    return path.split(".").last;
  }

  int? get fileSizeNumber {
    if (isFolder) {
      return 0;
    }
    var file = File(path);
    return file.lengthSync();
  }

  String get fileSizeString {
    var length = fileSizeNumber;
    if (length == null) {
      return "";
    }
    if (length < 1024) {
      return "$length B";
    } else if (length < 1024 * 1024) {
      return "${(length / 1024).toStringAsFixed(2)} KB";
    } else if (length < 1024 * 1024 * 1024) {
      return "${(length / 1024 / 1024).toStringAsFixed(2)} MB";
    } else {
      return "${(length / 1024 / 1024 / 1024).toStringAsFixed(2)} GB";
    }
  }

  String get lastModifiedString {
    if (isFolder) {
      return "";
    }
    var file = File(path);
    var lastModified = file.lastModifiedSync();
    return lastModified.toIso8601String();
  }

  String get parentPath {
    return Directory(path).parent.path;
  }

  factory QMFileModel.fromJson(Map<String, dynamic> json) =>
      _$QMFileModelFromJson(json);

  Map<String, dynamic> toJson() => _$QMFileModelToJson(this);

  // 从制定目录查询文件和文件夹
  static Future<List<QMFileModel>> selectFilesFromPath(String filePath,
      {bool justFolder = false, bool skipHidden = true}) async {
    var list = <QMFileModel>[];

    var realPath = await resolvePath(filePath);
    if (realPath == null) {
      return list;
    }
    if (Platform.isMacOS) {
      await _startAccessingSecurityScopedResource(filePath);
    }
    var dir = Directory(realPath);
    var lists = dir.listSync();
    for (var item in lists) {
      var filename = basename(item.path);
      if (skipHidden && filename.startsWith(".")) {
        continue;
      }
      var uid = generateMd5ForUUID(filename);
      if (justFolder && item is File) {
        continue;
      }
      var model = QMFileModel(uid, path: item.path, name: filename);
      model.isFolder = item is Directory;
      list.add(model);
    }

    return list;
  }

  static final _accessingSecurityScopedResourceMap = <String, String>{};

  static Future _startAccessingSecurityScopedResource(String fullPath) async {
    var model = await _findFilesystemItemRecursive(fullPath);
    if (model == null) {
      return Future.value();
    }
    if (_accessingSecurityScopedResourceMap.containsKey(model.uid)) {
      return Future.value();
    }
    var hostApi = QuantumHostApi();
    var newBookmarkData =
        await hostApi.startAccessingSecurityScopedResource(model.bookmarkData);
    if (newBookmarkData != null) {
      model.bookmarkData = newBookmarkData;
      _insertFilesystemItem(model);
    }
    _accessingSecurityScopedResourceMap[model.uid] = fullPath;

    return Future.value();
  }

  static Future _stopAccessingSecurityScopedResource(String fullPath) async {
    return Future.value();
  }

  static Future<String?> chooseFiles() async {
    var hostApi = QuantumHostApi();
    var dir = await hostApi.chooseDirectory();

    if (dir == null) {
      return null;
    }
    var model = QMFilesystemItem(generateMd5ForUUID(dir.absoluteUrl ?? ""),
        realPath: dir.absoluteUrl ?? "")
      ..showPath = dir.absoluteUrl ?? ""
      ..bookmarkData = dir.bookmarkString ?? "";
    await _insertFilesystemItem(model);

    return dir.absoluteUrl;
  }

  static Future<void> _insertFilesystemItem(QMFilesystemItem model) async {
    var sqlTextInsertFolder = '''
insert into filesystem_items(uid, name, show_path, real_path, bookmark_data)
values(:uid, :name, :showPath, :realPath, :bookmarkData)
on conflict(uid) do update set show_path = excluded.show_path, 
real_path = excluded.real_path, bookmark_data = excluded.bookmark_data;
''';
    var uuid = const Uuid();
    var uid = uuid.v4();
    var fsDb = await connectFilesystemDatabase();

    await fsDb.executeAsync(sqlTextInsertFolder, parameters: {
      ":uid": model.uid,
      ":name": stringTrimRight(model.name, "/"),
      ":showPath": stringTrimRight(model.showPath, "/"),
      ":realPath": stringTrimRight(model.realPath, "/"),
      ":bookmarkData": model.bookmarkData
    });
  }

  static Future<QMFilesystemItem?> _findFilesystemItemRecursive(
      String fullUrl) async {
    String resolvedPath = stringTrimRight(fullUrl, "/");
    var sqlText =
        "select * from filesystem_items where real_path = :resolvedPath";

    var fsDb = await connectFilesystemDatabase();
    while (true) {
      var list = await fsDb
          .executeAsync(sqlText, parameters: {":resolvedPath": resolvedPath});
      if (list.isNotEmpty) {
        var item = list[0];
        return QMFilesystemItem.fromJson(item);
      }
      resolvedPath = Directory(resolvedPath).parent.path;
      if (resolvedPath == "/" ||
          resolvedPath == "file://" ||
          resolvedPath == "file:") {
        break;
      }
    }
    return null;
  }
}
