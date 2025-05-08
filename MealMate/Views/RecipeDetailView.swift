import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var favourites: FavouritesManager
    @State private var showLoginAlert = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Recipe image
                AsyncImage(url: URL(string: recipe.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 250)
                .clipped()
                .cornerRadius(12)

                // Recipe Title + Favourite toggle
                HStack {
                    Text(recipe.name)
                        .font(.largeTitle)
                        .bold()

                    Spacer()

                    if userManager.isLoggedIn {
                        Button(action: {
                            favourites.toggle(recipeId: recipe.id)
                        }) {
                            Image(systemName: favourites.isFavourited(recipe.id) ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .font(.title2)
                        }
                    } else {
                        Button(action: {
                            showLoginAlert = true
                        }) {
                            Image(systemName: "heart")
                                .foregroundColor(.gray)
                                .font(.title2)
                        }
                        .alert(isPresented: $showLoginAlert) {
                            Alert(
                                title: Text("Sign In Required"),
                                message: Text("Please sign in to save favourites."),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                }

                // Quick info
                HStack(spacing: 15) {
                    Label("\(recipe.cookTimeText)", systemImage: "clock")
                    Label("\(recipe.servings) servings", systemImage: "person.2")
                    Label(recipe.difficulty, systemImage: "chart.bar")
                }
                .font(.subheadline)
                .foregroundColor(.gray)

                Divider()

                // Ingredients Section
                Text("Ingredients")
                    .font(.title2)
                    .bold()

                ForEach(recipe.ingredients, id: \.self) { item in
                    Text("• \(item)")
                }

                Divider()

                // Instructions Section
                Text("Instructions")
                    .font(.title2)
                    .bold()

                ForEach(recipe.instructions.indices, id: \.self) { index in
                    Text("\(index + 1). \(recipe.instructions[index])")
                        .padding(.bottom, 5)
                }

                Divider()

                // Extra info
                HStack {
                    Text("Cuisine: \(recipe.cuisine)")
                    Spacer()
                    Text("Calories: \(recipe.caloriesPerServing)")
                }
                .font(.footnote)
                .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
