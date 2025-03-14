import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    @State private var showingEloFilterSheet = false
    @AppStorage("userElo") private var currentUserElo: Int = 1000
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Filtro de ELO
                    HStack {
                        Text("Rango de búsqueda: \(viewModel.getSelectedRangeText())")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Button(action: { showingEloFilterSheet = true }) {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Lista de usuarios
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                    } else if viewModel.error != nil {
                        VStack {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                            Text(viewModel.error ?? "Error desconocido")
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    } else if viewModel.filteredUsers.isEmpty {
                        VStack {
                            Image(systemName: "person.slash")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                            Text("No se encontraron usuarios en este rango de ELO")
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    } else {
                        List(viewModel.filteredUsers) { user in
                            UserRowView(user: user, currentUserElo: currentUserElo)
                        }
                        .refreshable {
                            viewModel.filterUsersByElo(currentUserElo: currentUserElo)
                        }
                    }
                }
                
                // Botón flotante para actualizar
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.filterUsersByElo(currentUserElo: currentUserElo)
                        }) {
                            Image(systemName: "arrow.clockwise.circle.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Buscar Jugadores")
            .sheet(isPresented: $showingEloFilterSheet) {
                EloFilterSheet(
                    selectedRange: $viewModel.selectedEloRange,
                    availableRanges: viewModel.availableEloRanges
                ) {
                    viewModel.filterUsersByElo(currentUserElo: currentUserElo)
                }
            }
        }
        .onAppear {
            viewModel.filterUsersByElo(currentUserElo: currentUserElo)
        }
    }
}

struct UserRowView: View {
    let user: User
    let currentUserElo: Int
    
    var body: some View {
        HStack(spacing: 15) {
            // Imagen de perfil
            Image(user.profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(user.getEloColor(), lineWidth: 2)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(user.name)
                        .font(.headline)
                    
                    // Insignia de ELO
                    Text(user.getEloRank())
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(user.getEloColor().opacity(0.2))
                        .foregroundColor(user.getEloColor())
                        .clipShape(Capsule())
                }
                
                // Diferencia de ELO
                Text("ELO: \(user.elo) (\(eloDifference(user.elo)))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Juegos
                if !user.games.isEmpty {
                    Text(user.games.map { "\($0.0) [\($0.1)]" }.joined(separator: ", "))
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
        }
        .padding(.vertical, 8)
    }
    
    private func eloDifference(_ userElo: Int) -> String {
        let diff = userElo - currentUserElo
        return diff >= 0 ? "+\(diff)" : "\(diff)"
    }
}

struct EloFilterSheet: View {
    @Binding var selectedRange: Int
    let availableRanges: [(range: Int, text: String)]
    let onDismiss: () -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(availableRanges, id: \.range) { range in
                    Button(action: {
                        selectedRange = range.range
                        presentationMode.wrappedValue.dismiss()
                        onDismiss()
                    }) {
                        HStack {
                            Text(range.text)
                            Spacer()
                            if selectedRange == range.range {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Rango de búsqueda")
            .navigationBarItems(trailing: Button("Cerrar") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    UserListView()
} 