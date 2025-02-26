import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io' show Platform, Directory;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:quantum/generated_bindings.dart';

import 'bindings.dart';
import 'filesystem/path.dart';
import 'messages.g.dart';

class Quantum {
  static const MethodChannel _channel = MethodChannel('quantum');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // static Future<String?> chooseFiles() async {
  //   String? files = await _channel.invokeMethod("chooseFiles");
  //   if (files != null) {
  //     files = Uri.decodeFull(files);
  //   }
  //   return files;
  // }

  static Future<String?> getHostLanguage() async {
    var hostApi = QuantumHostApi();
    final String language = await hostApi.getHostLanguage();
    return language;
  }

  static String? resolvePath(String relativePath) {
    return PathHelper().resolvePath(relativePath);
  }
}
