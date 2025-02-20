import SwiftUI

struct LogginView: View {
    @StateObject private var viewModel: LoginViewModel
    
    init(authManager: AuthenticationManager) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(authManager: authManager))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.949, green: 0.949, blue: 0.949)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Logo y título principal
                    HStack {
                        Text("Team")
                            .font(.system(size: 40, weight: .bold)) +
                        Text("UP")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                    }
                    .padding(.top, 50)
                    
                    // Contenido principal
                    VStack(spacing: 15) {
                        Image("teamup_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150)
                            .padding(.top, 20)
                        
                        VStack(spacing: 10) {
                            Text("¡Bienvenido de nuevo!")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("Inicia sesión para continuar")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        .padding(.bottom, 30)
                        
                        // Campos de entrada
                        VStack(spacing: 15) {
                            TextField("", text: $viewModel.username)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .placeholder(when: viewModel.username.isEmpty) {
                                    Text("Usuario")
                                        .foregroundColor(.gray)
                                }
                                .autocapitalization(.none)
                            
                            SecureField("", text: $viewModel.password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .placeholder(when: viewModel.password.isEmpty) {
                                    Text("Contraseña")
                                        .foregroundColor(.gray)
                                }
                        }
                        .padding(.horizontal, 30)
                        
                        // Botón de inicio de sesión
                        Button(action: {
                            viewModel.login()
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
                        .alert(isPresented: $viewModel.showError) {
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
            }
            .navigationBarHidden(true)
        }
    }
} 