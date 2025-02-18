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
            ZStack {
                Color(red: 0.949, green: 0.949, blue: 0.949)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Logo y título
                    VStack(spacing: 10) {
                        Image("teamup_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150)
                        
                        Text("¡Bienvenido de nuevo!")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Inicia sesión para continuar")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 40)
                    
                    // Campos de entrada
                    VStack(spacing: 15) {
                        TextField("", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .placeholder(when: username.isEmpty) {
                                Text("Usuario")
                                    .foregroundColor(.gray)
                            }
                            .autocapitalization(.none)
                        
                        SecureField("", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .placeholder(when: password.isEmpty) {
                                Text("Contraseña")
                                    .foregroundColor(.gray)
                            }
                    }
                    .padding(.horizontal, 30)
                    
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
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    .alert(isPresented: $showError) {
                        Alert(
                            title: Text("Error de inicio de sesión"),
                            message: Text("Usuario o contraseña incorrectos"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    // Enlace para registrarse
                    NavigationLink(destination: RegisterView()) {
                        HStack {
                            Text("¿No tienes cuenta?")
                                .foregroundColor(.gray)
                            Text("Regístrate")
                                .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LogginView()
}

