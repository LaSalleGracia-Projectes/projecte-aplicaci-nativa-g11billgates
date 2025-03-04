import SwiftUI
import Foundation

struct ChatView: View {
    let user: User
    @State private var messageText = ""
    @State private var selectedUser: User?
    
    var body: some View {
        VStack(spacing: 0) {
            // Header personalizado
            HStack(spacing: 16) {
                Image(user.profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Button(action: {
                    selectedUser = user
                }) {
                    Text(user.name)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                }
                
                Spacer()
            }
            .padding()
            .background(Color(.systemBackground))
            .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
            
            // Área de mensajes (placeholder por ahora)
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<10) { i in
                        HStack {
                            if i % 2 == 0 {
                                Spacer()
                                Text("¡Hola! ¿Jugamos una partida?")
                                    .padding(12)
                                    .background(Color(red: 0.9, green: 0.3, blue: 0.2))
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            } else {
                                Text("¡Claro! Dame 5 minutos")
                                    .padding(12)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            
            // Campo de entrada de mensaje
            HStack(spacing: 12) {
                TextField("Mensaje", text: $messageText)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                
                Button(action: {
                    // Aquí iría la lógica para enviar el mensaje
                    if !messageText.isEmpty {
                        messageText = ""
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color(red: 0.9, green: 0.3, blue: 0.2))
                        .clipShape(Circle())
                }
            }
            .padding()
            .background(Color(.systemBackground))
        }
        .sheet(item: $selectedUser) { user in
            UserDetailView(user: user)
        }
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
