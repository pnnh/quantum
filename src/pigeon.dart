import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartPackageName: 'quantum',
  dartOut: 'lib/messages.g.dart',
  dartOptions: DartOptions(),
  cppOptions: CppOptions(namespace: 'quantum'),
  cppHeaderOut: 'windows/runner/messages.g.h',
  cppSourceOut: 'windows/runner/messages.g.cpp',
  gobjectHeaderOut: 'linux/messages.g.h',
  gobjectSourceOut: 'linux/messages.g.cc',
  gobjectOptions: GObjectOptions(),
  kotlinOut: 'android/app/src/main/kotlin/dev/flutter/quantum/Messages.g.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'macos/quantum/Sources/quantum/Messages.g.swift',
  swiftOptions: SwiftOptions(),
))
class DirectoryResponse {
  String? absoluteUrl;
  String? bookmarkString;
}

@HostApi()
abstract class QuantumHostApi {
  String getHostLanguage();

  DirectoryResponse? chooseDirectory();

  String? startAccessingSecurityScopedResource(String bookmarkString);

  @SwiftFunction('add(_:to:)')
  int add(int a, int b);

  @async
  bool sendMessage(String message);
}
