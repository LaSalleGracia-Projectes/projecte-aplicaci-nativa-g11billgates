import SwiftUI

struct MyUserView: View {
    @StateObject private var viewModel: MyUserViewModel
    
    init(user: User) {
        _viewModel = StateObject(wrappedValue: MyUserViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            Image(viewModel.user.profileImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .padding(.top, 20)
            
            TextField("Nombre", text: $viewModel.user.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
            
            TextField("Edad", value: $viewModel.user.age, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
            
            TextField("Descripción", text: $viewModel.user.description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
            
            Button(action: {
                viewModel.updateProfile(name: viewModel.user.name, age: viewModel.user.age, description: viewModel.user.description)
            }) {
                Text("Guardar Cambios")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .navigationTitle("Mi Perfil")
    }
} 