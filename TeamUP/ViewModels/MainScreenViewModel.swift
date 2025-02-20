import SwiftUI

class MainScreenViewModel: ObservableObject {
    @Published var currentIndex = 0
    @Published var users: [User] = [
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
            profileImage: "DwarfTestIcon"
        ),
        User(
            name: "Carlos",
            age: 28,
            gender: "Hombre",
            description: "Jugador competitivo buscando team",
            games: [
                ("Valorant", "Inmortal"),
                ("CS2", "Águila")
            ],
            profileImage: "DwarfTestIcon"
        )
    ]
    
    func likeUser() {
        moveToNextUser()
    }
    
    func dislikeUser() {
        moveToNextUser()
    }
    
    private func moveToNextUser() {
        if currentIndex < users.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0 // Reiniciar o manejar el fin de la lista
        }
    }
} 