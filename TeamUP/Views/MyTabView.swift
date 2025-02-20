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
                    Label("Main", systemImage: "house")
                }
            
            ChatListView()
                .tabItem {
                    Label("Chats", systemImage: "message")
                }
            
            MyUserView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                        .font(.system(size: 12))
                }
        }
        .navigationBarTitleDisplayMode(.inline)
        .accentColor(Color(red: 0.9, green: 0.3, blue: 0.2))
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    MyTabView()
}
