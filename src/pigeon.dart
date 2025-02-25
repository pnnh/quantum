import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
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
  dartPackageName: 'quantum',
))
class MessageData {
  MessageData({required this.data});

  String? name;
  String? description;
  Map<String, String> data;
}

@HostApi()
abstract class QuantumHostApi {
  String getHostLanguage();

  @SwiftFunction('add(_:to:)')
  int add(int a, int b);

  @async
  bool sendMessage(MessageData message);
}
