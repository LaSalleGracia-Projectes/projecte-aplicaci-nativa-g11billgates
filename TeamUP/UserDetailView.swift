import SwiftUI

struct UserDetailView: View {
    let username: String
    let age: Int
    let gender: String
    let description: String
    let games: [(name: String, rank: String)]
    let profileImage: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Imagen de perfil
                Image(profileImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 400)
                    .clipped()
                
                // Información del usuario
                VStack(spacing: 20) {
                    // Nombre, edad y género
                    HStack {
                        Text("\(username), \(age)")
                            .font(.title)
                            .bold()
                        
                        Text("•")
                            .foregroundColor(.secondary)
                        
                        Text(gender)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                    }
                    
                    // Descripción
                    if !description.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Sobre mí")
                                .font(.headline)
                                .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                            
                            Text(description)
                                .foregroundColor(.primary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Juegos y rangos
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Juegos")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                        
                        ForEach(games, id: \.name) { game in
                            HStack(spacing: 8) {
                                Image(systemName: "gamecontroller")
                                    .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                                
                                Text(game.name)
                                    .foregroundColor(.primary)
                                
                                Text("•")
                                    .foregroundColor(.secondary)
                                
                                Text(game.rank)
                                    .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                                
                                Spacer()
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(20)
                .background(Color(.systemBackground))
            }
        }
        .background(Color(.systemBackground))
        .navigationBarTitleDisplayMode(.inline)
    }
}
