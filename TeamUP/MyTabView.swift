//
//  ContentView.swift
//  TeamUP
//
//  Created by Marc Fernández on 7/2/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GameSelector()
                .tabItem {
                    Image(systemName: "list.bullet.circle")
                    Text("Games")
                }
            
            MainScreen()
                .tabItem {
                    Image(systemName: "gamecontroller.circle")
                    Text("Match")
                }
            
            ChatListView()
                .tabItem {
                    Image(systemName: "bubble.circle")
                    Text("Chats")
                }
            
            MyProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }
        .accentColor(Color(red: 0.8, green: 0.2, blue: 0.2)) // Rojo claro elegante
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
    ContentView()
}
