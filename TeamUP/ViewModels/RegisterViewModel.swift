import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var username = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var selectedGames: Set<Game> = []
    @Published var gender: Gender = .male
    @Published var filterByRank = false
    @Published var searchPreference: SearchPreference = .all
    @Published var profileImage: UIImage?
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var showImagePicker = false
    
    func validateFirstStep() -> Bool {
        // Validar email
        guard email.contains("@") else {
            showError = true
            errorMessage = "Por favor, introduce un email válido"
            return false
        }
        
        // Validar usuario
        guard username.count >= 3 else {
            showError = true
            errorMessage = "El usuario debe tener al menos 3 caracteres"
            return false
        }
        
        // Validar contraseña
        guard password.count >= 6 else {
            showError = true
            errorMessage = "La contraseña debe tener al menos 6 caracteres"
            return false
        }
        
        // Validar confirmación de contraseña
        guard password == confirmPassword else {
            showError = true
            errorMessage = "Las contraseñas no coinciden"
            return false
        }
        
        return true
    }
    
    func register() {
        // Validar que se haya seleccionado al menos un juego
        guard !selectedGames.isEmpty else {
            showError = true
            errorMessage = "Debes seleccionar al menos un juego"
            return
        }
        
        // Aquí iría la lógica para guardar en la base de datos
        // Por ahora, solo simulamos el registro
        print("Usuario registrado exitosamente")
    }
} 