import Foundation

struct RecipeCategory: Identifiable {
    let id = UUID()
    let title: String
    let recipes: [Recipe]
}
