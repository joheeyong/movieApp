import UIKit
import Flutter
import ChannelIOFront

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    ChannelIO.initialize(application)
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    FlutterMethodChannel(
      name: ChannelIOManager.CHANNEL_CHANNELIO,
      binaryMessenger: controller.binaryMessenger
    ).setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      switch call.method {
      case "boot": ChannelIOManager.shared.boot(
        bootConfig: (call.arguments as? [String:Any?])?["bootConfig"] as? [String:Any?],
        result: result
      )
      case "sleep": ChannelIOManager.shared.sleep()
      case "shutdown": ChannelIOManager.shared.shutdown()
      case "showChannelButton": ChannelIOManager.shared.showChannelButton()
      case "showMessenger": ChannelIOManager.shared.showMessenger()
      case "track": ChannelIOManager.shared.track(eventName: call.arguments as? String)
      case "updateUser": ChannelIOManager.shared.updateProfile(
        (call.arguments as? [String:Any?])?["updateUser"] as? [String:Any?]
      )
            default: break
      }
    }
    
    let handler = BadgeHandler()
    FlutterEventChannel(
      name: ChannelIOManager.CHANNEL_BADGE_EVENT,
      binaryMessenger: controller.binaryMessenger
    ).setStreamHandler(handler)
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
