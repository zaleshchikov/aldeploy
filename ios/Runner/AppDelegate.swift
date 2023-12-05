import UIKit
import YandexMapsMobile
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    YMKMapKit.setApiKey("36463aba-6a5e-4ae2-8897-7636d1930233")
    GMSServices.provideAPIKey("AIzaSyAQZvhCXXdOkzusUN9Me2eKNVAd4ySORf4")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}




