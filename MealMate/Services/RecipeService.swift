import Foundation

class RecipeService {
    static let shared = RecipeService()

    func fetchRecipes(limit: Int = 30, skip: Int = 0, completion: @escaping ([Recipe]) -> Void) {
        let urlStr = "https://dummyjson.com/recipes?limit=\(limit)&skip=\(skip)"
        guard let url = URL(string: urlStr) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print("Fetch error:", error?.localizedDescription ?? "Unknown")
                return
            }

            do {
                let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded.recipes)
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }

    func fetchRecipe(id: Int, completion: @escaping (Recipe?) -> Void) {
        let urlStr = "https://dummyjson.com/recipes/\(id)"
        guard let url = URL(string: urlStr) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print("Error:", error?.localizedDescription ?? "Unknown")
                return
            }

            do {
                let recipe = try JSONDecoder().decode(Recipe.self, from: data)
                DispatchQueue.main.async {
                    completion(recipe)
                }
            } catch {
                print("Error decoding single recipe:", error)
                completion(nil)
            }
        }.resume()
    }
    
    func searchRecipes(query: String, completion: @escaping ([Recipe]) -> Void) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlStr = "https://dummyjson.com/recipes/search?q=\(encodedQuery)"

        guard let url = URL(string: urlStr) else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print("Search error:", error?.localizedDescription ?? "Unknown")
                completion([])
                return
            }

            do {
                let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded.recipes)
                }
            } catch {
                print("Search decode error:", error)
                completion([])
            }
        }.resume()
    }
}
