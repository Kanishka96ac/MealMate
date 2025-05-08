import SwiftUI

struct SignInView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var email = ""
    @State private var password = ""
    @State private var loginError = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Sign In").font(.largeTitle).bold()

            TextField("Email", text: $email).keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding().background(Color(.secondarySystemBackground)).cornerRadius(10)

            SecureField("Password", text: $password)
                .padding().background(Color(.secondarySystemBackground)).cornerRadius(10)

            if !loginError.isEmpty {
                Text(loginError).foregroundColor(.red).font(.caption)
            }

            Button("Sign In") {
                userManager.signIn(email: email, password: password) { success in
                    if !success {
                        loginError = userManager.errorMessage
                    }
                }
            }
            .padding().frame(maxWidth: .infinity)
            .background(Color.green).foregroundColor(.white).cornerRadius(10)

            NavigationLink("Don't have an account? Sign Up", destination: SignUpView())
                .font(.footnote)

            Spacer()
        }
        .padding().navigationTitle("Login")
    }
}
