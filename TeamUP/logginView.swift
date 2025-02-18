//
//  loggin.swift
//  TeamUP
//
//  Created by Marc Fernández on 13/2/25.
//

import SwiftUI

struct LogginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showError = false
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Logo
                Image("teamup_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .padding(.bottom, 50)
                
                // Campos de entrada
                TextField("Usuario", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.none)
                
                SecureField("Contraseña", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Botón de inicio de sesión
                Button(action: {
                    if !authManager.login(username: username, password: password) {
                        showError = true
                    }
                }) {
                    Text("Iniciar sesión")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.9, green: 0.3, blue: 0.2))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .alert(isPresented: $showError) {
                    Alert(
                        title: Text("Error de inicio de sesión"),
                        message: Text("Usuario o contraseña incorrectos"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                // Enlace para registrarse
                NavigationLink(destination: RegisterView()) {
                    Text("¿No tienes cuenta? Regístrate")
                        .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                }
            }
            .padding()
        }
    }
}

#Preview {
    LogginView()
}

