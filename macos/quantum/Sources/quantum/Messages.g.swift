// Autogenerated from Pigeon (v24.2.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

/// Error class for passing custom error details to Dart side.
final class PigeonError: Error {
  let code: String
  let message: String?
  let details: Sendable?

  init(code: String, message: String?, details: Sendable?) {
    self.code = code
    self.message = message
    self.details = details
  }

  var localizedDescription: String {
    return
      "PigeonError(code: \(code), message: \(message ?? "<nil>"), details: \(details ?? "<nil>")"
      }
}

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let pigeonError = error as? PigeonError {
    return [
      pigeonError.code,
      pigeonError.message,
      pigeonError.details,
    ]
  }
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// Generated class from Pigeon that represents data sent in messages.
struct DirectoryResponse {
  var absoluteUrl: String? = nil
  var bookmarkString: String? = nil


  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> DirectoryResponse? {
    let absoluteUrl: String? = nilOrValue(pigeonVar_list[0])
    let bookmarkString: String? = nilOrValue(pigeonVar_list[1])

    return DirectoryResponse(
      absoluteUrl: absoluteUrl,
      bookmarkString: bookmarkString
    )
  }
  func toList() -> [Any?] {
    return [
      absoluteUrl,
      bookmarkString,
    ]
  }
}

private class MessagesPigeonCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 129:
      return DirectoryResponse.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class MessagesPigeonCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? DirectoryResponse {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class MessagesPigeonCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return MessagesPigeonCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return MessagesPigeonCodecWriter(data: data)
  }
}

class MessagesPigeonCodec: FlutterStandardMessageCodec, @unchecked Sendable {
  static let shared = MessagesPigeonCodec(readerWriter: MessagesPigeonCodecReaderWriter())
}


/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol QuantumHostApi {
  func getHostLanguage() throws -> String
  func chooseDirectory() throws -> DirectoryResponse?
  func startAccessingSecurityScopedResource(bookmarkString: String) throws -> String?
  func add(_ a: Int64, to b: Int64) throws -> Int64
  func sendMessage(message: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class QuantumHostApiSetup {
  static var codec: FlutterStandardMessageCodec { MessagesPigeonCodec.shared }
  /// Sets up an instance of `QuantumHostApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: QuantumHostApi?, messageChannelSuffix: String = "") {
    let channelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
    let getHostLanguageChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.quantum.QuantumHostApi.getHostLanguage\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getHostLanguageChannel.setMessageHandler { _, reply in
        do {
          let result = try api.getHostLanguage()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getHostLanguageChannel.setMessageHandler(nil)
    }
    let chooseDirectoryChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.quantum.QuantumHostApi.chooseDirectory\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      chooseDirectoryChannel.setMessageHandler { _, reply in
        do {
          let result = try api.chooseDirectory()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      chooseDirectoryChannel.setMessageHandler(nil)
    }
    let startAccessingSecurityScopedResourceChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.quantum.QuantumHostApi.startAccessingSecurityScopedResource\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      startAccessingSecurityScopedResourceChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let bookmarkStringArg = args[0] as! String
        do {
          let result = try api.startAccessingSecurityScopedResource(bookmarkString: bookmarkStringArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      startAccessingSecurityScopedResourceChannel.setMessageHandler(nil)
    }
    let addChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.quantum.QuantumHostApi.add\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      addChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let aArg = args[0] as! Int64
        let bArg = args[1] as! Int64
        do {
          let result = try api.add(aArg, to: bArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      addChannel.setMessageHandler(nil)
    }
    let sendMessageChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.quantum.QuantumHostApi.sendMessage\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      sendMessageChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let messageArg = args[0] as! String
        api.sendMessage(message: messageArg) { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      sendMessageChannel.setMessageHandler(nil)
    }
  }
}
