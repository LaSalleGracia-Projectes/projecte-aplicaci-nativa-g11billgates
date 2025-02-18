import SwiftUI

class AuthenticationManager: ObservableObject {
    @Published var isLoggedIn = false
    
    // Credenciales de prueba
    private let testUsername = "user"
    private let testPassword = "1234"
    
    func login(username: String, password: String) -> Bool {
        if username == testUsername && password == testPassword {
            isLoggedIn = true
            return true
        }
        return false
    }
    
    func logout() {
        isLoggedIn = false
    }
} 