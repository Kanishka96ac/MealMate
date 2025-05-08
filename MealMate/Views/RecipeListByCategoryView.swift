import SwiftUI

struct RecipeListByCategoryView: View {
    let title: String
    let recipes: [Recipe]

    var body: some View {
        List(recipes) { recipe in
            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                HStack(spacing: 12) {
                    AsyncImage(url: URL(string: recipe.image)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)

                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .font(.headline)
                        Text(recipe.cookTimeText)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle(title)
    }
}
