import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    func register() {
        if username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "Por favor, rellena todos los campos"
            showError = true
            return
        }
        
        if !email.contains("@") || !email.contains(".") {
            errorMessage = "Por favor, introduce un email válido"
            showError = true
            return
        }
        
        if password != confirmPassword {
            errorMessage = "Las contraseñas no coinciden"
            showError = true
            return
        }
        
        if password.count < 6 {
            errorMessage = "La contraseña debe tener al menos 6 caracteres"
            showError = true
            return
        }
        
        // Aquí iría la lógica de registro
    }
} 