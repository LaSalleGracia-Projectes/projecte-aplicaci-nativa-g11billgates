//
//  TeamUPApp.swift
//  TeamUP
//
//  Created by Marc Fernández on 7/2/25.
//
import SwiftUI

@main
struct TeamUPApp: App {
    @StateObject private var authManager = AuthenticationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView() //TEST
                .environmentObject(authManager)
        }
    }
}

