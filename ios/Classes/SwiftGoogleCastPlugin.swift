import Flutter
import UIKit
import GoogleCast

public class SwiftGoogleCastPlugin: NSObject, GCKLoggerDelegate, FlutterPlugin, UIApplicationDelegate {

    let kDebugLoggingEnabled = true
    private var channel: FlutterMethodChannel?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftGoogleCastPlugin()

        instance.channel = FlutterMethodChannel(name: "google_cast.context", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: instance.channel!)

        FGCSessionManagerMethodChannel.register(with: registrar)
        FGCSessionMethodChannel.register(with: registrar)
        FGCDiscoveryManagerMethodChannel.register(with: registrar)
        RemoteMediaClienteMethodChannel.register(with: registrar)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setSharedInstanceWithOptions":
            setSharedInstanceWithOption(arguments: call.arguments as! [String: Any], result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func setSharedInstanceWithOption(arguments: [String: Any], result: @escaping FlutterResult) {
        let option = GCKCastOptions.fromMap(arguments)
        GCKCastContext.setSharedInstanceWith(option)

        let context = GCKCastContext.sharedInstance()
        GCKLogger.sharedInstance().delegate = self
        GCKLogger.sharedInstance().consoleLoggingEnabled = true

        context.discoveryManager.add(FGCDiscoveryManagerMethodChannel.instance)
        context.sessionManager.add(FGCSessionManagerMethodChannel.instance)
        context.discoveryManager.startDiscovery()

      //this is throwing an error on the flutter side that expects a bool
      //         result(nil)

      //testing a patch with setting this to true
      result(true)
    }

    // MARK: - GCKLoggerDelegate

    public func logMessage(_ message: String,
                           at level: GCKLoggerLevel,
                           fromFunction function: String,
                           location: String) {
        print("[GCKLogger] \(function): \(message)")
    }
}