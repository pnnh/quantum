import Cocoa
import FlutterMacOS
import Foundation

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
    case "chooseFiles":
        result(promptForWorkingDirectoryPermission())
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    
    public func promptForWorkingDirectoryPermission() -> String? {
       let openPanel = NSOpenPanel()
       openPanel.message = "Choose your directory"
       openPanel.prompt = "Choose"
       openPanel.allowedFileTypes = ["none"]
       openPanel.allowsOtherFileTypes = false
       openPanel.canChooseFiles = false
       openPanel.canChooseDirectories = true
       
    let response = openPanel.runModal()
       print("openPanel.urls \(openPanel.urls)") // this contains the chosen folder
        let absUrl = openPanel.urls.first?.absoluteString
        return absUrl
    }
}
