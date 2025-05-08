import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {

                // Home page image
                Image("mealmate")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding(.top, 40)

                Text("Welcome to MealMate")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)

                Text("Discover delicious recipes across categories like Pizza, Cake, Pasta and more!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Discover Recipes (Guest Access)
                NavigationLink(destination: RecipeCollectionsView()) {
                    Text("🍽️ Discover Recipes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                // Auth options
                HStack(spacing: 20) {
                    NavigationLink(destination: SignInView()) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }

                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("MealMate")
            .navigationBarHidden(true)
        }
    }
}
