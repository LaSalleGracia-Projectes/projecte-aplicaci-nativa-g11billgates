import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var navigateToGamesSelection = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Logo
                    VStack(spacing: 0) {
                        Text("Team")
                            .font(.system(size: 40, weight: .bold)) +
                        Text("UP")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                    }
                    .padding(.bottom, 40)
                    
                    // Campos de registro
                    VStack(spacing: 15) {
                        TextField("Correo electrónico", text: $viewModel.email)
                            .textFieldStyle(CustomTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        
                        TextField("Usuario", text: $viewModel.username)
                            .textFieldStyle(CustomTextFieldStyle())
                            .autocapitalization(.none)
                        
                        SecureField("Contraseña", text: $viewModel.password)
                            .textFieldStyle(CustomTextFieldStyle())
                            .textContentType(.none)
                            .autocapitalization(.none)
                        
                        SecureField("Confirmar contraseña", text: $viewModel.confirmPassword)
                            .textFieldStyle(CustomTextFieldStyle())
                            .textContentType(.none)
                            .autocapitalization(.none)
                    }
                    .padding(.horizontal, 20)
                    
                    // Mensaje de error
                    if viewModel.showError {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                            .transition(.opacity)
                    }
                    
                    // Botón Continuar
                    Button(action: {
                        if viewModel.validateFirstStep() {
                            navigateToGamesSelection = true
                        }
                    }) {
                        Text("Continuar")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(red: 0.9, green: 0.3, blue: 0.2))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
                .padding()
            }
            .navigationDestination(isPresented: $navigateToGamesSelection) {
                RegisterGamesView(viewModel: viewModel)
            }
            .navigationBarBackButtonHidden(false)
        }
    }
} 