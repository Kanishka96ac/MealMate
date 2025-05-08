import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false

    func loadRecipes(limit: Int = 80, skip: Int = 0) {
        isLoading = true
        RecipeService.shared.fetchRecipes(limit: limit, skip: skip) { [weak self] fetched in
            self?.recipes = fetched
            self?.isLoading = false
        }
    }
}
