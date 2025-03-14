import SwiftUI

class MainScreenViewModel: ObservableObject {
    @Published var currentIndex = 0
    @Published var users: [User] = []
    @Published var showMatch = false
    @Published var matchedUser: User?
    
    // Usuario actual (normalmente vendría de AuthenticationManager)
    private var currentUser: User
    
    init() {
        // Inicializar el usuario actual (esto debería venir del AuthenticationManager en una implementación real)
        self.currentUser = User(
            name: "CurrentUser",
            age: 25,
            gender: "Hombre",
            description: "Jugador activo",
            games: [
                ("League of Legends", "Platino"),
                ("Valorant", "Oro")
            ],
            profileImage: "DefaultIcon"
        )
        
        // Inicializar usuarios de ejemplo con ELO
        self.users = [
            User(
                name: "Alex",
                age: 23,
                gender: "Hombre",
                description: "Buscando equipo para rankeds",
                games: [
                    ("League of Legends", "Platino"),
                    ("Valorant", "Oro")
                ],
                profileImage: "DwarfTestIcon"
            ),
            User(
                name: "Laura",
                age: 25,
                gender: "Mujer",
                description: "Main support, looking for ADC",
                games: [
                    ("League of Legends", "Diamante"),
                    ("World of Warcraft", "2100+")
                ],
                profileImage: "ToadTestIcon"
            ),
            User(
                name: "Roger",
                age: 28,
                gender: "Hombre",
                description: "Jugador competitivo buscando team",
                games: [
                    ("Valorant", "Inmortal"),
                    ("CS2", "Águila")
                ],
                profileImage: "TerroristTestIcon"
            )
        ]
        
        // Ordenar usuarios por compatibilidad de ELO
        sortUsersByEloCompatibility()
    }
    
    func likeUser() {
        guard currentIndex < users.count else { return }
        
        let likedUser = users[currentIndex]
        
        // Actualizar ELO si hay juegos en común
        updateEloForMatch(with: likedUser)
        
        // Comprobar si hay match (en una implementación real, esto verificaría si el otro usuario también dio like)
        let isMatch = shouldCreateMatch(with: likedUser)
        if isMatch {
            matchedUser = likedUser
            showMatch = true
            saveMatch(with: likedUser)
        }
        
        moveToNextUser()
    }
    
    func dislikeUser() {
        moveToNextUser()
    }
    
    private func moveToNextUser() {
        if currentIndex < users.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = users.count
            // Recargar usuarios y ordenarlos por compatibilidad
            loadMoreUsers()
            sortUsersByEloCompatibility()
        }
    }
    
    private func updateEloForMatch(with matchedUser: User) {
        // Actualizar ELO para cada juego en común
        for (game, _) in currentUser.games {
            if let matchedGame = matchedUser.games.first(where: { $0.0 == game }),
               let currentElo = currentUser.gameElos[game],
               let matchedElo = matchedUser.gameElos[game] {
                
                // En este ejemplo, consideramos un "like" como una victoria (1.0)
                let newCurrentElo = EloSystem.calculateNewRating(
                    currentRating: currentElo,
                    opponentRating: matchedElo,
                    actualScore: 1.0
                )
                
                // Actualizar ELO del usuario actual
                currentUser.updateElo(forGame: game, newElo: newCurrentElo)
            }
        }
    }
    
    private func shouldCreateMatch(with user: User) -> Bool {
        // Lógica simplificada de match - en una implementación real,
        // esto verificaría si el otro usuario también dio like
        return true
    }
    
    private func sortUsersByEloCompatibility() {
        users.sort { user1, user2 in
            let diff1 = calculateEloCompatibility(with: user1)
            let diff2 = calculateEloCompatibility(with: user2)
            return diff1 < diff2
        }
    }
    
    private func calculateEloCompatibility(with user: User) -> Double {
        var totalDiff = 0.0
        var count = 0
        
        // Calcular la diferencia de ELO para cada juego en común
        for (game, _) in currentUser.games {
            if let currentElo = currentUser.gameElos[game],
               let userElo = user.gameElos[game] {
                totalDiff += abs(currentElo - userElo)
                count += 1
            }
        }
        
        // Retornar la diferencia promedio, o infinito si no hay juegos en común
        return count > 0 ? totalDiff / Double(count) : Double.infinity
    }
    
    private func loadMoreUsers() {
        // En una implementación real, esto cargaría más usuarios de la base de datos
        // Por ahora, solo reiniciamos el índice
        currentIndex = 0
    }
    
    private func saveMatch(with user: User) {
        // TODO: Implementar la lógica para guardar el match en la base de datos
        // Por ejemplo:
        // DatabaseManager.shared.saveMatch(currentUser: currentUser, matchedUser: user)
    }
}
