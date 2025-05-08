import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @State private var query: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search recipes...", text: $query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: query) {
                        viewModel.search(for: query)
                    }

                if viewModel.isLoading {
                    ProgressView("Searching...")
                } else if viewModel.searchResults.isEmpty && !query.isEmpty {
                    Text("No results found.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.searchResults) { recipe in
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
                            .padding(.vertical, 4)
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("Search")
        }
    }
}
