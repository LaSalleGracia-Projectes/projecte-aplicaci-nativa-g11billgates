//
//  ChatListView.swift
//  TeamUP
//
//  Created by Marc Fernández on 7/2/25.
//

import SwiftUI

struct ChatPreview: Identifiable {
    let id = UUID()
    let username: String
    let lastMessage: String
    let timestamp: String
    let profileImage: String // Nombre de la imagen en Assets
}

struct ChatListView: View {
    let chats: [ChatPreview] = [
        ChatPreview(username: "Ana", lastMessage: "¿Jugamos una partida?", timestamp: "12:30", profileImage: "profile1"),
        ChatPreview(username: "Carlos", lastMessage: "Buen juego!", timestamp: "11:45", profileImage: "profile2"),
        ChatPreview(username: "Elena", lastMessage: "¿Mañana a las 5?", timestamp: "10:15", profileImage: "profile3"),
        ChatPreview(username: "David", lastMessage: "GG WP", timestamp: "Ayer", profileImage: "profile4")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                ZStack {
                    HStack {
                        Spacer()
                        Text("Team")
                            .font(.system(size: 28, weight: .bold)) +
                        Text("UP")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: AjustesView()) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 22))
                                .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                        }
                        .padding(.trailing)
                    }
                }
                .padding(.vertical)
                .background(Color(.systemBackground))
                .shadow(color: .black.opacity(0.2), radius: 5, y: 2)
                
                // Lista de chats
                List(chats, id: \.username) { chat in
                    NavigationLink(destination: ChatView(chat: chat)) {
                        HStack {
                            Image(chat.profileImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(chat.username)
                                    .font(.system(size: 16, weight: .semibold))
                                
                                Text(chat.lastMessage)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Text(chat.timestamp)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

#Preview {
    ChatListView()
}
