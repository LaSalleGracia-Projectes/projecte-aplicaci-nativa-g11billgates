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
                    Label("Inicio", systemImage: "house")
                }
            
            SettingsView()
                .tabItem {
                    Label("Ajustes", systemImage: "gear")
                }
            
            MyUserView(user: User(name: "Marc", age: 25, gender: "Hombre", description: "Descripción", games: [], profileImage: "profile"))
                .tabItem {
                    Label("Perfil", systemImage: "person")
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
