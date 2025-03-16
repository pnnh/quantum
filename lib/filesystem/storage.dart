import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart';
import 'package:quantum/database/database.dart';

part 'storage.g.dart';

@JsonSerializable()
class QMFilesystemItem {
  String uid;
  String name;
  @JsonKey(name: "real_path")
  String realPath = "";
  @JsonKey(name: "show_path")
  String showPath = "";
  @JsonKey(name: "bookmark_data")
  String bookmarkData = "";

  QMFilesystemItem(this.uid,
      {required this.realPath, this.showPath = "", this.name = "测试文件"});

  factory QMFilesystemItem.fromJson(Map<String, dynamic> json) =>
      _$QMFilesystemItemFromJson(json);

  Map<String, dynamic> toJson() => _$QMFilesystemItemToJson(this);

  bool get isHidden {
    return name.startsWith(".");
  }

  String get fileMime {
    return "";
  }

  String get fileExtension {
    return realPath.split(".").last;
  }

  int? get fileSizeNumber {
    return 0;
  }

  String get fileSizeString {
    return "";
  }

  String get lastModifiedString {
    return "";
  }
}

Future<QMSqliteClient> connectFilesystemDatabase() async {
  var initSql = '''
create table if not exists main.filesystem_items
(
    uid   text primary key,
    name  text,
    show_path text,
    real_path text not null,
    bookmark_data text
);
''';
  var fsDb = await QMSqliteClient.connect(join("quantum", "filesystem.db"));
  if (fsDb == null) {
    throw Exception("数据库连接失败");
  }
  await fsDb.executeAsync(initSql);
  return fsDb;
}
