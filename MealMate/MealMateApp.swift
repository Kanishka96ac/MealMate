import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct MealMateApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userManager = UserManager()
    @StateObject var favourites = FavouritesManager()

    var body: some Scene {
        WindowGroup {
            if userManager.isLoggedIn {
                MainAppView()
                    .environmentObject(userManager)
                    .environmentObject(favourites)
            } else {
                HomeView()
                    .environmentObject(userManager)
                    .environmentObject(favourites)
            }
        }
    }
}
