import SwiftUI

struct RecipeCollectionsView: View {
    @StateObject private var viewModel = GroupedRecipesViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Discover Recipes")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)

                if viewModel.isLoading {
                    ProgressView("Loading...").padding()
                } else {
                    ForEach(viewModel.tagsToShow, id: \.self) { tag in
                        if let recipes = viewModel.groupedRecipes[tag] {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(tag)
                                        .font(.title2)
                                        .bold()
                                    Spacer()
                                    NavigationLink(destination: RecipeListByCategoryView(title: tag, recipes: recipes)) {
                                        Text("\(recipes.count)+ Recipes")
                                            .foregroundColor(.blue)
                                            .font(.subheadline)
                                    }
                                }
                                .padding(.horizontal)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(recipes.prefix(5)) { recipe in
                                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                                RecipeCardView(recipe: recipe)
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.top)
        }
        .onAppear {
            viewModel.loadGroupedRecipes()
        }
    }
}
