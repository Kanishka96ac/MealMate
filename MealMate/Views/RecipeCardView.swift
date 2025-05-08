import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(height: 180)
            .cornerRadius(10)

            Text(recipe.name)
                .font(.headline)
                .lineLimit(1)

            Text(recipe.cookTimeText)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 160)
    }
}
