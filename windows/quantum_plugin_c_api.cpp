#include "include/quantum/quantum_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "quantum_plugin.h"

void QuantumPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  quantum::QuantumPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
