import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchResults: [Recipe] = []
    @Published var isLoading = false

    func search(for query: String) {
        guard !query.isEmpty else {
            searchResults = []
            return
        }

        isLoading = true
        RecipeService.shared.searchRecipes(query: query) { [weak self] results in
            self?.searchResults = results
            self?.isLoading = false
        }
    }
}
