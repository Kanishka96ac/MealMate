import Foundation

class FavouritesManager: ObservableObject {
    @Published private(set) var favourites: [Int] = []

    private var storageKey: String {
        let userEmail = UserDefaults.standard.string(forKey: "currentEmail") ?? "guest"
        return "favourites_" + userEmail
    }

    init() {
        loadFavourites()

        NotificationCenter.default.addObserver(forName: .userDidSignIn, object: nil, queue: .main) { _ in
            self.loadFavourites()
        }

        NotificationCenter.default.addObserver(forName: .userDidSignOut, object: nil, queue: .main) { _ in
            self.loadFavourites()
        }
    }

    func toggle(recipeId: Int) {
        if favourites.contains(recipeId) {
            favourites.removeAll { $0 == recipeId }
        } else {
            favourites.append(recipeId)
        }
        saveFavourites()
    }

    func isFavourited(_ id: Int) -> Bool {
        favourites.contains(id)
    }

    private func saveFavourites() {
        UserDefaults.standard.set(favourites, forKey: storageKey)
    }

    private func loadFavourites() {
        favourites = UserDefaults.standard.array(forKey: storageKey) as? [Int] ?? []
    }
}
