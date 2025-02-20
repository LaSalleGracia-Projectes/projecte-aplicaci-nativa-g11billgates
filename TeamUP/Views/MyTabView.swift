//
//  ContentView.swift
//  TeamUP
//
//  Created by Marc Fernández on 7/2/25.
//

import SwiftUI

struct MyTabView: View {
    @AppStorage("isDarkMode") private var isDarkMode = true
    
    var body: some View {
        TabView {
            MainScreenView()
                .tabItem {
                    Label("Play", systemImage: "gamecontroller")
                }
            
            ChatListView()
                .tabItem {
                    Label("Chat", systemImage: "bubble")
                }
            
            MyUserView(user: User(
                name: "user",
                age: 25,
                gender: "Hombre",
                description: "¡Hola! Me encanta jugar videojuegos competitivos.",
                games: [
                    ("League of Legends", "Diamante"),
                    ("World of Warcraft", "2400+")
                ],
                profileImage: "DwarfTestIcon"
            ))
                .tabItem {
                    Label("User", systemImage: "person")
                }
        }
        .accentColor(Color(red: 0.9, green: 0.3, blue: 0.2))
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    MyTabView()
}
