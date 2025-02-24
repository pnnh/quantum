import 'dart:async';

import 'package:flutter/services.dart';

import 'database/database.dart';
import 'filesystem/path.dart';

const String _libName = 'quantum';

class Quantum {
  static const MethodChannel _channel = MethodChannel('quantum');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> chooseFiles() async {
    final String? files = await _channel.invokeMethod("chooseFiles");
    return files;
  }

  static String? resolvePath(String relativePath) {
    return PathHelper().resolvePath(relativePath);
  }

  static void pluginSayHello() {
    QADatabase.instance.pluginSayHello();
  }
}
