import SwiftUI

class UserViewModel: ObservableObject {
    @Published var user: User
    @Published var isEditingProfile = false
    @Published var tempBio: String = ""
    @Published var selectedGames: [Game] = []
    @Published var gameRanks: [String: String] = [:]
    
    init(user: User) {
        self.user = user
        self.tempBio = user.description
        
        // Inicializar juegos y rangos desde el usuario
        for (gameName, rank) in user.games {
            if let game = GamesList.allGames.first(where: { $0.name == gameName }) {
                selectedGames.append(game)
                gameRanks[gameName] = rank
            }
        }
    }
    
    func updateProfile() {
        user.description = tempBio
        
        // Actualizar juegos y rangos
        var updatedGames: [(String, String)] = []
        for game in selectedGames {
            if let rank = gameRanks[game.name] {
                updatedGames.append((game.name, rank))
            }
        }
        user.games = updatedGames
        
        // Aquí se guardarían los cambios en la base de datos
        isEditingProfile = false
    }
    
    func addGame(_ game: Game) {
        if !selectedGames.contains(where: { $0.id == game.id }) {
            selectedGames.append(game)
            gameRanks[game.name] = game.ranks.first ?? "Sin rango"
        }
    }
    
    func removeGame(_ game: Game) {
        selectedGames.removeAll(where: { $0.id == game.id })
        gameRanks.removeValue(forKey: game.name)
    }
} 