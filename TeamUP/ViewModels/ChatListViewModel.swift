import SwiftUI
import Combine

class ChatListViewModel: ObservableObject {
    @Published var chats: [ChatPreview] = [
        ChatPreview(username: "Ana", lastMessage: "¿Jugamos una partida?", timestamp: "12:30", profileImage: "profile1"),
        ChatPreview(username: "Carlos", lastMessage: "Buen juego!", timestamp: "11:45", profileImage: "profile2"),
        ChatPreview(username: "Elena", lastMessage: "¿Mañana a las 5?", timestamp: "10:15", profileImage: "profile3"),
        ChatPreview(username: "David", lastMessage: "GG WP", timestamp: "Ayer", profileImage: "profile4")
    ]
    
    // Lista de usuarios para poder mostrar sus perfiles
    private var users: [User] = [
        User(name: "Ana", age: 23, gender: "Mujer", description: "¡Hola! Me encanta jugar League of Legends y Valorant.", games: [("League of Legends", "Platino"), ("Valorant", "Oro")], profileImage: "profile1"),
        User(name: "Carlos", age: 28, gender: "Hombre", description: "Jugador competitivo", games: [("CS2", "Águila"), ("Valorant", "Diamante")], profileImage: "profile2"),
        User(name: "Elena", age: 25, gender: "Mujer", description: "Main support", games: [("League of Legends", "Platino")], profileImage: "profile3"),
        User(name: "David", age: 27, gender: "Hombre", description: "Buscando team para rankeds", games: [("Valorant", "Inmortal")], profileImage: "profile4")
    ]
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Suscribirse a notificaciones de nuevos chats
        NotificationCenter.default.publisher(for: NSNotification.Name("NewChatAdded"))
            .sink { [weak self] notification in
                if let chat = notification.userInfo?["chat"] as? ChatPreview {
                    DispatchQueue.main.async {
                        // Añadir el nuevo chat al principio de la lista
                        self?.chats.insert(chat, at: 0)
                        
                        // Si el usuario no existe en la lista, lo añadimos
                        if let matchedUser = notification.userInfo?["user"] as? User {
                            self?.addUserIfNeeded(matchedUser)
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func findUser(withName name: String) -> User? {
        return users.first { $0.name == name }
    }
    
    private func addUserIfNeeded(_ user: User) {
        if !users.contains(where: { $0.name == user.name }) {
            users.append(user)
        }
    }
} 