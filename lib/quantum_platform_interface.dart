import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'quantum_method_channel.dart';

abstract class QuantumPlatform extends PlatformInterface {
  /// Constructs a QuantumPlatform.
  QuantumPlatform() : super(token: _token);

  static final Object _token = Object();

  static QuantumPlatform _instance = MethodChannelQuantum();

  /// The default instance of [QuantumPlatform] to use.
  ///
  /// Defaults to [MethodChannelQuantum].
  static QuantumPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [QuantumPlatform] when
  /// they register themselves.
  static set instance(QuantumPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
