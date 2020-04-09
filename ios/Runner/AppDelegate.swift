import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
     [GMSServices provideAPIKey: @"AIzaSyBkOHzpPK4V5a29w54BgQGQYG96g67om9s"];
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
