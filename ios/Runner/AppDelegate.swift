import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR KEY HERE")
    GeneratedPluginRegistrant.register(with: self)

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let shareChannel = FlutterMethodChannel(name: "com.waada.customer/share",
                                              binaryMessenger: controller.binaryMessenger)
    shareChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "share" {
        guard let args = call.arguments as? [String: Any],
              let text = args["text"] as? String else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Text to share was null", details: nil))
          return
        }
        self?.shareText(text: text, controller: controller)
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func shareText(text: String, controller: UIViewController) {
    let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
    if let popoverController = activityViewController.popoverPresentationController {
      popoverController.sourceView = controller.view
      popoverController.sourceRect = CGRect(x: controller.view.bounds.midX, y: controller.view.bounds.midY, width: 0, height: 0)
      popoverController.permittedArrowDirections = []
    }
    controller.present(activityViewController, animated: true, completion: nil)
  }
}
