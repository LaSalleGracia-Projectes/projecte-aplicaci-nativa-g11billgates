import SwiftUI

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    func login(username: String, password: String) -> Bool {
        // Credenciales de prueba
        if username == "user" && password == "1234" {
            isAuthenticated = true
            return true
        }
        return false
    }
    
    func logout() {
        isAuthenticated = false
    }
}