import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var signUpError = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up").font(.largeTitle).bold()

            TextField("Email", text: $email).keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding().background(Color(.secondarySystemBackground)).cornerRadius(10)

            SecureField("Password", text: $password)
                .padding().background(Color(.secondarySystemBackground)).cornerRadius(10)

            SecureField("Confirm Password", text: $confirmPassword)
                .padding().background(Color(.secondarySystemBackground)).cornerRadius(10)

            if !signUpError.isEmpty {
                Text(signUpError).foregroundColor(.red).font(.caption)
            }

            Button("Sign Up") {
                guard password == confirmPassword else {
                    signUpError = "Passwords do not match"
                    return
                }

                userManager.signUp(email: email, password: password) { success in
                    if !success {
                        signUpError = userManager.errorMessage
                    }
                }
            }
            .padding().frame(maxWidth: .infinity)
            .background(Color.blue).foregroundColor(.white).cornerRadius(10)

            NavigationLink("Already have an account? Sign In", destination: SignInView())
                .font(.footnote)

            Spacer()
        }
        .padding().navigationTitle("Register")
    }
}
