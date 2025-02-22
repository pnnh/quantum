import 'dart:io' show Platform;

import 'package:path/path.dart' show join;

class PathHelper {
  static const String workDirPrefix = "file://work";
  static const String blogDirPrefix = "file://blog";

  String? resolvePath(String path) {
    String? realPath = path;
    if (path.startsWith(workDirPrefix)) {
      var workDir = getAppWorkDir();
      if (workDir == null) {
        return null;
      }
      realPath = join(workDir, path.substring(workDirPrefix.length));
    } else if (path.startsWith(blogDirPrefix)) {
      var blogDir = getBlogDir();
      realPath = join(blogDir, path.substring(blogDirPrefix.length));
    }

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
    return "/home/Projects/Pnnh/blog";
  }
}
