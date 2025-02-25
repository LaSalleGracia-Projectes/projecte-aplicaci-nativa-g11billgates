import Foundation

enum AuthError: LocalizedError {
    case invalidCredentials
    case emptyUsername
    case emptyPassword
    case weakPassword
    case invalidEmail
    case usernameTaken
    case emailTaken
    case passwordMismatch
    case networkError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Usuario o contraseña incorrectos"
        case .emptyUsername:
            return "Por favor, introduce un nombre de usuario"
        case .emptyPassword:
            return "Por favor, introduce una contraseña"
        case .weakPassword:
            return "La contraseña debe tener al menos 6 caracteres"
        case .invalidEmail:
            return "Por favor, introduce un email válido"
        case .usernameTaken:
            return "El nombre de usuario ya está en uso"
        case .emailTaken:
            return "El email ya está registrado"
        case .passwordMismatch:
            return "Las contraseñas no coinciden"
        case .networkError:
            return "Error de conexión. Por favor, inténtalo de nuevo"
        case .unknown:
            return "Ha ocurrido un error inesperado"
        }
    }
}