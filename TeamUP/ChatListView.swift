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
    let time: String
    let unreadCount: Int
    let profileImage: String // Nombre de la imagen en Assets
}

struct ChatListView: View {
    @State private var showingSettings = false
    
    // Chats de prueba
    let chats = [
        ChatPreview(
            username: "DragonSlayer",
            lastMessage: "¿Jugamos una partida?",
            time: "12:30",
            unreadCount: 2,
            profileImage: "DwarfTestIcon"
        ),
        ChatPreview(
            username: "ProGamer123",
            lastMessage: "GG WP!",
            time: "Ayer",
            unreadCount: 0,
            profileImage: "DwarfTestIcon"
        )
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header consistente
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showingSettings = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.primary)
                            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                    }
                    .padding(.trailing, 20)
                }
                .overlay(
                    HStack(spacing: 0) {
                        Text("Team")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary) +
                        Text("UP")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                    }
                )
                .frame(height: 50)
                .background(Color(.systemBackground))
                .shadow(color: .black.opacity(0.2), radius: 5, y: 2)
                .sheet(isPresented: $showingSettings) {
                    AjustesView()
                }
                
                // Lista de chats
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(chats) { chat in
                            ChatRow(chat: chat)
                            
                            Divider()
                                .padding(.leading, 76)
                        }
                    }
                }
                .background(Color(.systemBackground))
            }
            .navigationBarHidden(true)
        }
    }
}

struct ChatRow: View {
    let chat: ChatPreview
    
    var body: some View {
        NavigationLink(destination: ChatView(chat: chat)) {
            HStack(spacing: 12) {
                // Imagen de perfil
                Image(chat.profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 52, height: 52)
                    .clipShape(Circle())
                
                // Información del chat
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(chat.username)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text(chat.time)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text(chat.lastMessage)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        if chat.unreadCount > 0 {
                            Text("\(chat.unreadCount)")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 18, height: 18)
                                .background(Color(red: 0.9, green: 0.3, blue: 0.2))
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    ChatListView()
}
