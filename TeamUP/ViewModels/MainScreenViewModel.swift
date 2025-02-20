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
            profileImage: "ToadTestIcon"
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
            profileImage: "TerroristTestIcon"
        ),
        User(
            name: "Saten",
            age: 24,
            gender: "Mujer",
            description: "Hola me llamo Saten soy maja",
            games: [
                ("Valorant", "Inmortal"),
                ("CS2", "Águila")
            ],
            profileImage: "CatTestIcon"
        ),
        User(
            name: "Marc",
            age: 20,
            gender: "Hombre",
            description: "Mejor player del wow españa",
            games: [
                ("WoW", "2900"),
                ("CS2", "Águila")
            ],
            profileImage: "DogTestIcon"
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
            currentIndex = users.count
        }
    }
}
