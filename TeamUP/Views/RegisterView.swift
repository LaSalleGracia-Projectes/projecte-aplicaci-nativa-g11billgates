import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(red: 0.949, green: 0.949, blue: 0.949)
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 15) {
                    HStack {
                        Text("Crear cuenta")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    HStack {
                        Text("¡Bienvenido! Por favor, introduce tus datos")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                .padding(.horizontal)
                
                VStack(spacing: 15) {
                    TextField("", text: $viewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .placeholder(when: viewModel.username.isEmpty) {
                            Text("Usuario")
                                .foregroundColor(.gray)
                        }
                    
                    TextField("", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .placeholder(when: viewModel.email.isEmpty) {
                            Text("Email")
                                .foregroundColor(.gray)
                        }
                    
                    SecureField("", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .placeholder(when: viewModel.password.isEmpty) {
                            Text("Contraseña")
                                .foregroundColor(.gray)
                        }
                    
                    SecureField("", text: $viewModel.confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .placeholder(when: viewModel.confirmPassword.isEmpty) {
                            Text("Confirmar contraseña")
                                .foregroundColor(.gray)
                        }
                }
                .padding()
                
                Button(action: {
                    viewModel.register()
                }) {
                    Text("Registrarse")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.9, green: 0.3, blue: 0.2))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .alert(isPresented: $viewModel.showError) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
                }
                
                Spacer()
            }
        }
        .navigationBarTitle("Registro", displayMode: .inline)
    }
} 