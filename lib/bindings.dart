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
  late final QuantumNative _quantumNative = loadNativeLibrary();

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
    _quantumNative.QMLogInfo(
        "Hello, world!".toNativeUtf8() as ffi.Pointer<ffi.Char>);
    return _quantumNative.add(a, b);
  }

  void pluginSayHello() {
    // _helloWorld();
    //
    // // 尝试调用sum，传递和返回int参数
    // print('3 + 5 = ${_quantumNative.sum(3, 5)}');
    //
    // // 尝试调用subtract，传递指针
    // final p = calloc<Int>();
    // p.value = 3;
    // print('3 - 5 = ${_quantumNative.subtract(p, 5)}');
    // calloc.free(p); // 释放dart端分配的内存
    //
    // // 尝试调用multiply，返回指针
    // final resultPointer = _quantumNative.multiply(3, 5);
    // final int result = resultPointer.value;
    // print('3 * 5 = $result');
    // _quantumNative.free_pointer(resultPointer); // 释放native端分配的内存
  }
}
