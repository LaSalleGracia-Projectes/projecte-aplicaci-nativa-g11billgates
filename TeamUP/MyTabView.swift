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
            GameListView()
                .tabItem {
                    Image(systemName: "list.bullet.circle")
                    Text("Games")
                        .font(.system(size: 12))
                }
            
            MainScreenView()
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
            
            MyUserView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                        .font(.system(size: 12))
                }
        }
        .accentColor(Color(red: 0.9, green: 0.3, blue: 0.2))
        .preferredColorScheme(.dark) // Fuerza inicialmente el tema oscuro
    }
}

#Preview {
    MyTabView()
}
