import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let isFromCurrentUser: Bool
    let timestamp: String
}

struct ChatView: View {
    let chat: ChatPreview
    @State private var messageText = ""
    @State private var messages: [Message] = [
        Message(content: "¿Jugamos una partida?", isFromCurrentUser: false, timestamp: "12:30"),
        Message(content: "¡Claro! Dame 5 minutos", isFromCurrentUser: true, timestamp: "12:31"),
        Message(content: "Perfect!", isFromCurrentUser: false, timestamp: "12:31")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack(spacing: 8) {
                NavigationLink(destination: UserDetailView(
                    username: chat.username,
                    age: 25,
                    gender: "Hombre",
                    description: "¡Hola! Me encanta jugar videojuegos competitivos y siempre busco mejorar. Principalmente juego League of Legends y World of Warcraft, pero estoy abierto a probar nuevos juegos.",
                    games: [
                        ("League of Legends", "Diamante"),
                        ("World of Warcraft", "2400+")
                    ],
                    profileImage: chat.profileImage
                )) {
                    HStack(spacing: 6) {
                        Image(chat.profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                        
                        Text(chat.username)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.top, 0)
            .padding(.bottom, 4)
            .background(Color(.systemBackground))
            .shadow(color: .black.opacity(0.2), radius: 5, y: 2)
            
            // Mensajes
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(messages) { message in
                        MessageBubble(message: message)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .background(Color(.systemBackground))
            
            // Campo de entrada de mensaje
            HStack(spacing: 12) {
                TextField("Mensaje", text: $messageText)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        let newMessage = Message(content: messageText, isFromCurrentUser: true, timestamp: "Ahora")
        messages.append(newMessage)
        messageText = ""
    }
}

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser { Spacer() }
            
            VStack(alignment: message.isFromCurrentUser ? .trailing : .leading) {
                Text(message.content)
                    .padding(12)
                    .background(message.isFromCurrentUser ? 
                        Color(red: 0.9, green: 0.3, blue: 0.2) : 
                        Color(.systemGray6))
                    .foregroundColor(message.isFromCurrentUser ? .white : .primary)
                    .cornerRadius(16)
                
                Text(message.timestamp)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 4)
            }
            
            if !message.isFromCurrentUser { Spacer() }
        }
    }
}
