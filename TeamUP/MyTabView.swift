//
//  ContentView.swift
//  TeamUP
//
//  Created by Marc Fernández on 7/2/25.
//

import SwiftUI

struct MyTabView: View {
    var body: some View {
        TabView {
            GameSelector()
                .tabItem {
                    Image(systemName: "list.bullet.circle")
                    Text("Games")
                        .font(.system(size: 12))
                }
            
            MainScreen()
                .tabItem {
                    Image(systemName: "gamecontroller.circle")
                    Text("Match")
                        .font(.system(size: 12))
                }
            
            ChatListView()
                .tabItem {
                    Image(systemName: "bubble.circle")
                    Text("Chats")
                        .font(.system(size: 12))
                }
            
            MyProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                        .font(.system(size: 12))
                }
        }
        .accentColor(Color(red: 0.9, green: 0.3, blue: 0.2)) // Rojo más brillante y ligeramente anaranjado
        .preferredColorScheme(.dark) // Tema oscuro
    }
}

// Vistas temporales básicas para cada tab
struct GameSelector: View {
    var body: some View {
        Text("Game Selector")
    }
}

struct MainScreen: View {
    var body: some View {
        Text("Main Screen")
    }
}

struct ChatListView: View {
    var body: some View {
        Text("Chat List")
    }
}

struct MyProfileView: View {
    var body: some View {
        Text("My Profile")
    }
}

#Preview {
    MyTabView()
}
