import Foundation
import FirebaseAuth
import SwiftUI

class UserManager: ObservableObject {
    @Published var errorMessage: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("currentEmail") var currentEmail: String = ""

    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(false)
                } else {
                    self.currentEmail = email
                    self.isLoggedIn = true
                    completion(true)
                }
            }
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(false)
                } else {
                    self.currentEmail = email
                    self.isLoggedIn = true

                    // Notify other parts
                    NotificationCenter.default.post(name: .userDidSignIn, object: nil)

                    completion(true)
                }
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            currentEmail = ""
            NotificationCenter.default.post(name: .userDidSignOut, object: nil)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
