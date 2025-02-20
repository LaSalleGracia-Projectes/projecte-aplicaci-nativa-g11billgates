import SwiftUI

struct LogginView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Iniciar Sesión")
                    .font(.largeTitle)
                    .padding()
                
                TextField("Usuario", text: $username)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Contraseña", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    if !authManager.login(username: username, password: password) {
                        showError = true
                    }
                }) {
                    Text("Iniciar sesión")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showError) {
                    Alert(title: Text("Error"), message: Text("Usuario o contraseña incorrectos"), dismissButton: .default(Text("OK")))
                }
                
                Spacer()
            }
            .padding()
        }
    }
}