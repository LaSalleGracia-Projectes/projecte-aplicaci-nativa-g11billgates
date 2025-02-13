//
//  loggin.swift
//  TeamUP
//
//  Created by Marc Fernández on 13/2/25.
//

import SwiftUI

struct LogginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showingRegister = false
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Logo
                VStack(spacing: 0) {
                    Text("Team")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.primary) +
                    Text("UP")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                }
                .padding(.top, 60)
                .padding(.bottom, 40)
                
                // Campos de entrada
                VStack(spacing: 20) {
                    // Email
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .foregroundColor(.gray)
                        TextField("tu@email.com", text: $email)
                            .textFieldStyle(CustomTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                    }
                    
                    // Contraseña
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Contraseña")
                            .foregroundColor(.gray)
                        SecureField("••••••••", text: $password)
                            .textFieldStyle(CustomTextFieldStyle())
                    }
                }
                .padding(.horizontal, 30)
                
                // Botón de login
                Button(action: {
                    // Aquí iría la lógica de login
                    isLoggedIn = true
                }) {
                    Text("Iniciar Sesión")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(red: 0.9, green: 0.3, blue: 0.2))
                        .cornerRadius(25)
                }
                .padding(.horizontal, 30)
                
                // Separador
                HStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)
                    Text("O")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)
                }
                .padding(.horizontal, 30)
                
                // Botón de registro
                Button(action: {
                    showingRegister = true
                }) {
                    Text("Crear cuenta")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(red: 0.9, green: 0.3, blue: 0.2), lineWidth: 2)
                        )
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .background(Color(.systemBackground))
            .navigationBarHidden(true)
            .sheet(isPresented: $showingRegister) {
                RegisterView()
            }
            .fullScreenCover(isPresented: $isLoggedIn) {
                MainScreenView()
            }
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }
}

#Preview {
    LogginView()
}

