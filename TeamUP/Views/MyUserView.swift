import SwiftUI

struct MyUserView: View {
    @StateObject private var viewModel: UserViewModel
    @State private var showSettings = false
    @State private var showGameSelector = false
    
    init(user: User) {
        _viewModel = StateObject(wrappedValue: UserViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                ZStack {
                    HStack {
                        Spacer()
                        Text("Team")
                            .font(.system(size: 28, weight: .bold)) +
                        Text("UP")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            showSettings = true
                        }) {
                            Image(systemName: "gear")
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                        }
                        .padding(.trailing, 16)
                    }
                }
                .padding(.vertical, 8)
                .background(Color(.systemBackground))
                .shadow(color: .black.opacity(0.2), radius: 5, y: 2)
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Imagen de perfil
                        Image(viewModel.user.profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(red: 0.9, green: 0.3, blue: 0.2), lineWidth: 3))
                            .padding(.top, 20)
                        
                        // Información del usuario
                        VStack(spacing: 8) {
                            Text(viewModel.user.name)
                                .font(.system(size: 24, weight: .bold))
                            
                            HStack {
                                Text("\(viewModel.user.age) años")
                                Text("•")
                                Text(viewModel.user.gender)
                            }
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        }
                        
                        // Biografía
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Biografía")
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Spacer()
                                
                                if viewModel.isEditingProfile {
                                    Button("Guardar") {
                                        viewModel.updateProfile()
                                    }
                                    .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                                } else {
                                    Button("Editar") {
                                        viewModel.isEditingProfile = true
                                        viewModel.tempBio = viewModel.user.description
                                    }
                                    .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                                }
                            }
                            
                            if viewModel.isEditingProfile {
                                TextEditor(text: $viewModel.tempBio)
                                    .frame(height: 100)
                                    .padding(8)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                            } else {
                                Text(viewModel.user.description)
                                    .font(.system(size: 16))
                                    .padding(8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                        
                        // Juegos
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Mis juegos")
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Spacer()
                                
                                if viewModel.isEditingProfile {
                                    Button("Añadir") {
                                        showGameSelector = true
                                    }
                                    .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                                }
                            }
                            
                            ForEach(viewModel.selectedGames) { game in
                                HStack {
                                    Image(game.icon)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(8)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(game.name)
                                            .font(.system(size: 16, weight: .semibold))
                                        
                                        if viewModel.isEditingProfile {
                                            Picker("Rango", selection: Binding(
                                                get: { viewModel.gameRanks[game.name] ?? game.ranks.first ?? "" },
                                                set: { viewModel.gameRanks[game.name] = $0 }
                                            )) {
                                                ForEach(game.ranks, id: \.self) { rank in
                                                    Text(rank).tag(rank)
                                                }
                                            }
                                            .pickerStyle(.menu)
                                        } else {
                                            Text(viewModel.gameRanks[game.name] ?? "Sin rango")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    if viewModel.isEditingProfile {
                                        Button(action: {
                                            viewModel.removeGame(game)
                                        }) {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                                .padding(8)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                        
                        Spacer()
                    }
                }
            }
            .background(Color(.systemGray6))
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .sheet(isPresented: $showGameSelector) {
                GameSelectorView(selectedGames: viewModel.selectedGames) { game in
                    viewModel.addGame(game)
                }
            }
        }
    }
}

// Vista para seleccionar juegos
struct GameSelectorView: View {
    var selectedGames: [Game]
    var onGameSelected: (Game) -> Void
    @Environment(\.dismiss) var dismiss
    
    var availableGames: [Game] {
        GamesList.allGames.filter { game in
            !selectedGames.contains(where: { $0.id == game.id })
        }
    }
    
    var body: some View {
        NavigationStack {
            List(availableGames) { game in
                Button(action: {
                    onGameSelected(game)
                    dismiss()
                }) {
                    HStack {
                        Image(game.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)
                        
                        Text(game.name)
                            .font(.system(size: 16))
                        
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Seleccionar juego")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
} 
