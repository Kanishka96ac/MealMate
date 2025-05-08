import Foundation

class GroupedRecipesViewModel: ObservableObject {
    @Published var groupedRecipes: [String: [Recipe]] = [:]
    @Published var isLoading = false

    // Only these tags/categories will be displayed
    let tagsToShow = ["Pizza", "Cake", "Pasta", "Salad", "Burger", "Biryani", "Sandwich"]

    func loadGroupedRecipes() {
        isLoading = true

        RecipeService.shared.fetchRecipes(limit: 100) { [weak self] allRecipes in
            guard let self = self else { return }

            var grouped: [String: [Recipe]] = [:]

            for tag in self.tagsToShow {
                let filtered = allRecipes.filter { $0.tags.contains(tag) }
                if !filtered.isEmpty {
                    grouped[tag] = filtered
                }
            }

            DispatchQueue.main.async {
                self.groupedRecipes = grouped
                self.isLoading = false
            }
        }
    }
}
