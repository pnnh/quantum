import 'dart:io';
import 'package:flutter/foundation.dart';
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

// 获取App的工作目录，一般是各个平台下的App沙盒目录
String? getAppWorkDir() {
  String os = Platform.operatingSystem;
  String? home = "";
  Map<String, String> envVars = Platform.environment;
  if (Platform.isMacOS) {
    home = join(envVars['HOME'] as String, "Documents");
  } else if (Platform.isLinux) {
    home = envVars['HOME'];
  } else if (Platform.isWindows) {
    home = envVars['UserProfile'];
  }
  print("getAppWorkDir: $home");
  return home;
}

String getBlogDir() {
  if (Platform.isWindows) {
    return "C:\\Projects\\Pnnh\\blog";
  }
  return "/Users/Larry/Projects/github/blog";
}
