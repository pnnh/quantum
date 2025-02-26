import Cocoa
import FlutterMacOS

public class QuantumPlugin: NSObject, @preconcurrency FlutterPlugin {
    nonisolated public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "quantum", binaryMessenger: registrar.messenger)
    let instance = QuantumPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
        
        let apiImpl =  QuantumHostApiImpl()
        QuantumHostApiSetup.setUp(binaryMessenger: registrar.messenger, api: apiImpl)
        
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString) 
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    
}
