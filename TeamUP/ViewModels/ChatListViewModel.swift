import SwiftUI
import Combine

class ChatListViewModel: ObservableObject {
    @Published var chats: [ChatPreview] = [
        ChatPreview(username: "Ana", lastMessage: "¿Jugamos una partida?", timestamp: "12:30", profileImage: "profile1"),
        ChatPreview(username: "Carlos", lastMessage: "Buen juego!", timestamp: "11:45", profileImage: "profile2"),
        ChatPreview(username: "Elena", lastMessage: "¿Mañana a las 5?", timestamp: "10:15", profileImage: "profile3"),
        ChatPreview(username: "David", lastMessage: "GG WP", timestamp: "Ayer", profileImage: "profile4")
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
                    }
                }
            }
            .store(in: &cancellables)
    }
} 