import SwiftUI

struct MainAppView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var favourites: FavouritesManager

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {

                // Greeting and logout
                HStack {
                    VStack(alignment: .leading) {
                        Text("Welcome back,")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(userManager.currentEmail)
                            .font(.headline)
                    }
                    Spacer()
                    Button("Logout") {
                        userManager.logout()
                    }
                    .foregroundColor(.red)
                }
                .padding(.horizontal)

                // Search Recipes
                NavigationLink(destination: SearchView()) {
                    Text("🔍 Search Recipes")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                }

                // Favourite Recipes
                NavigationLink(destination: FavouritesView()) {
                    Text("❤️ Your Favourites")
                        .font(.headline)
                        .foregroundColor(.pink)
                        .padding(.horizontal)
                }

                Divider()

                // Recipe collections (by tag)
                RecipeCollectionsView()

                Spacer()
            }
            .navigationTitle("MealMate")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
