import UIKit
import Flutter
// import GooglePlaces

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//     GMSServices.provideAPIKey("AIzaSyCtPxGy4YRi5KNcJYpgLHT0AgQurY5fZ9g")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
