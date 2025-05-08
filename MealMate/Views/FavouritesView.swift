import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var favourites: FavouritesManager
    @StateObject var viewModel = RecipeViewModel()

    var body: some View {
        List {
            ForEach(viewModel.recipes.filter { favourites.isFavourited($0.id) }) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    HStack {
                        AsyncImage(url: URL(string: recipe.image)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)

                        VStack(alignment: .leading) {
                            Text(recipe.name).font(.headline)
                            Text(recipe.cookTimeText).font(.caption).foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .navigationTitle("Your Favourites")
        .onAppear {
            viewModel.loadRecipes(limit: 100) // Load all recipes
        }
    }
}
