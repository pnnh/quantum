#ifndef FLUTTER_PLUGIN_QUANTUM_PLUGIN_H_
#define FLUTTER_PLUGIN_QUANTUM_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace quantum {

class QuantumPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  QuantumPlugin();

  virtual ~QuantumPlugin();

  // Disallow copy and assign.
  QuantumPlugin(const QuantumPlugin&) = delete;
  QuantumPlugin& operator=(const QuantumPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace quantum

#endif  // FLUTTER_PLUGIN_QUANTUM_PLUGIN_H_
