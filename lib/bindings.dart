import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io' show Platform, Directory;
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'generated_bindings.dart';

typedef HelloWorldFunc = ffi.Void Function();
typedef HelloWorld = void Function();

class FFIBindings {
  late final QuantumNative quantumNative = loadNativeLibrary();

  QuantumNative loadNativeLibrary() {
    var dylib = _openNativeLibrary('MTQuantum');
    return QuantumNative(dylib);
  }

  DynamicLibrary _openNativeLibrary(String libName) {
    debugPrint("current dir: ${Directory.current}");
    if (Platform.isMacOS || Platform.isIOS) {
      return DynamicLibrary.process();
    }
    if (Platform.isAndroid || Platform.isLinux) {
      return DynamicLibrary.open('lib$libName.so');
    }
    if (Platform.isWindows) {
      return DynamicLibrary.open('$libName.dll');
    }
    throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
  }

  int nativeAdd(int a, int b) {
    quantumNative.QMLogInfo(
        "Hello, world!".toNativeUtf8() as ffi.Pointer<ffi.Char>);
    return quantumNative.add(a, b);
  }
}
