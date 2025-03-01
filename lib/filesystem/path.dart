import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

const String workDirPrefix = "file://work";
const String blogDirPrefix = "file://blog";
const String filesystemPrefix = "file://";

Future<String?> resolvePath(String path) async {
  String? realPath = path;
  if (path.startsWith(workDirPrefix)) {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var workDir = appDocDir.path;
    realPath = join(workDir, path.substring(workDirPrefix.length));
  } else if (path.startsWith(blogDirPrefix)) {
    var blogDir = getBlogDir();
    realPath = join(blogDir, path.substring(blogDirPrefix.length));
  } else if (path.startsWith(filesystemPrefix)) {
    realPath = path.substring(filesystemPrefix.length);
  }
  print("quantum resolvePath: $realPath");

  return realPath;
}

// 递归检测目录是否存在，不存在时创建
Future<void> createDirectoryRecursively(String path) async {
  final directory = Directory(path);
  if (await directory.exists()) {
    print("Directory already exists: $path");
  } else {
    await directory.create(recursive: true);
    print("Directory created: $path");
  }
}

// 获取App的工作目录，一般是各个平台下的App沙盒目录
Future<String?> prepareAppWorkDir(String relativePath) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();

  var fullPath = join(appDocDir.path, relativePath);
  print("getAppWorkDir: $fullPath");
  await createDirectoryRecursively(fullPath);
  return fullPath;
}

String getBlogDir() {
  if (Platform.isWindows) {
    return "C:\\Projects\\Pnnh\\blog";
  }
  return "/Users/Larry/Projects/github/blog";
}
