import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Classic UIKit window (no SceneDelegate)
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        print("✅ AppDelegate didFinishLaunching (no scenes)")

        // Create window and root view controller manually
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = MainViewController()
        let nav = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()

        return true
    }
}
