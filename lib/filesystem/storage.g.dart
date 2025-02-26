// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QMFilesystemItem _$QMFilesystemItemFromJson(Map<String, dynamic> json) =>
    QMFilesystemItem(
      json['uid'] as String,
      realPath: json['real_path'] as String,
      showPath: json['show_path'] as String? ?? "",
      name: json['name'] as String? ?? "测试文件",
    )..bookmarkData = json['bookmark_data'] as String;

Map<String, dynamic> _$QMFilesystemItemToJson(QMFilesystemItem instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'real_path': instance.realPath,
      'show_path': instance.showPath,
      'bookmark_data': instance.bookmarkData,
    };
