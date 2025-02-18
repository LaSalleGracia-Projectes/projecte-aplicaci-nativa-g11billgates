import SwiftUI

struct RegisterView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
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
                    TextField("", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .placeholder(when: username.isEmpty) {
                            Text("Usuario")
                                .foregroundColor(.gray)
                        }
                    
                    TextField("", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .placeholder(when: email.isEmpty) {
                            Text("Email")
                                .foregroundColor(.gray)
                        }
                    
                    SecureField("", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .placeholder(when: password.isEmpty) {
                            Text("Contraseña")
                                .foregroundColor(.gray)
                        }
                    
                    SecureField("", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .placeholder(when: confirmPassword.isEmpty) {
                            Text("Confirmar contraseña")
                                .foregroundColor(.gray)
                        }
                }
                .padding()
                
                Button(action: {
                    if validateFields() {
                        // Aquí iría la lógica de registro
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Registrarse")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.9, green: 0.3, blue: 0.2))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func validateFields() -> Bool {
        if username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            alertMessage = "Por favor, rellena todos los campos"
            showingAlert = true
            return false
        }
        
        if !email.contains("@") || !email.contains(".") {
            alertMessage = "Por favor, introduce un email válido"
            showingAlert = true
            return false
        }
        
        if password != confirmPassword {
            alertMessage = "Las contraseñas no coinciden"
            showingAlert = true
            return false
        }
        
        if password.count < 6 {
            alertMessage = "La contraseña debe tener al menos 6 caracteres"
            showingAlert = true
            return false
        }
        
        return true
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
