import Foundation

struct User: Identifiable, Codable {
    let id = UUID()
    var name: String
    var age: Int
    var gender: String
    var description: String
    var games: [(String, String)] // (nombre del juego, rango)
    var profileImage: String
    var elo: Int
    
    init(name: String, age: Int, gender: String, description: String, games: [(String, String)], profileImage: String, elo: Int = 1000) {
        self.name = name
        self.age = age
        self.gender = gender
        self.description = description
        self.games = games
        self.profileImage = profileImage
        self.elo = elo
    }
}

// Extensión para decodificar desde la API
extension User {
    static func fromAPI(_ data: [String: Any]) -> User? {
        guard 
            let name = data["Nombre"] as? String,
            let age = data["Edad"] as? Int,
            let gender = data["Genero"] as? String,
            let description = data["Descripcion"] as? String,
            let games = data["Juegos"] as? [[String: String]],
            let profileImage = data["FotoPerfil"] as? String,
            let elo = data["ELO"] as? Int
        else {
            return nil
        }
        
        let formattedGames = games.compactMap { game -> (String, String)? in
            guard let name = game["nombre"], let rank = game["rango"] else { return nil }
            return (name, rank)
        }
        
        return User(
            name: name,
            age: age,
            gender: gender,
            description: description,
            games: formattedGames,
            profileImage: profileImage,
            elo: elo
        )
    }
} 