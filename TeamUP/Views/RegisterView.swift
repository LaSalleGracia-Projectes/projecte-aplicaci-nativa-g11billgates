import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            TextField("", text: $username)
                .placeholder(when: username.isEmpty) {
                    Text("Nombre de usuario").foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)

            TextField("", text: $email)
                .placeholder(when: email.isEmpty) {
                    Text("Correo electrónico").foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)

            SecureField("", text: $password)
                .placeholder(when: password.isEmpty) {
                    Text("Contraseña").foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)

            // Otros elementos de la vista
        }
        .padding()
    }
} 