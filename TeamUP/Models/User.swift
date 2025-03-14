import Foundation
import SwiftUI

struct User: Identifiable, Codable {
    let id = UUID()
    var name: String
    var age: Int
    var gender: String
    var description: String
    var games: [(String, String)] // (nombre del juego, rango)
    var profileImage: String
    var gameElos: [String: Double] // Diccionario que almacena el ELO para cada juego
    
    init(name: String, age: Int, gender: String, description: String, games: [(String, String)], profileImage: String) {
        self.name = name
        self.age = age
        self.gender = gender
        self.description = description
        self.games = games
        self.profileImage = profileImage
        
        // Inicializar ELOs por defecto (1200 es el ELO inicial estándar)
        var initialElos: [String: Double] = [:]
        for (game, _) in games {
            initialElos[game] = 1200.0
        }
        self.gameElos = initialElos
    }
    
    // Codificación personalizada para la API
    enum CodingKeys: String, CodingKey {
        case name = "Nombre"
        case age = "Edad"
        case gender = "Genero"
        case description = "Descripcion"
        case games = "Juegos"
        case profileImage = "FotoPerfil"
        case gameElos = "GameELOs"
    }
    
    // Función para actualizar el ELO de un juego específico
    mutating func updateElo(forGame game: String, newElo: Double) {
        gameElos[game] = newElo
    }
    
    // Función para obtener el ELO promedio del usuario
    func getAverageElo() -> Double {
        guard !gameElos.isEmpty else { return 1200.0 }
        let total = gameElos.values.reduce(0.0, +)
        return total / Double(gameElos.count)
    }
    
    // Función para obtener el rango de ELO de un juego específico
    func getEloRank(forGame game: String) -> String {
        guard let elo = gameElos[game] else { return "Sin clasificar" }
        
        switch elo {
        case 0...999:
            return "Bronce"
        case 1000...1499:
            return "Plata"
        case 1500...1999:
            return "Oro"
        case 2000...2499:
            return "Platino"
        default:
            return "Diamante"
        }
    }
    
    // Función para obtener el color del rango de un juego específico
    func getEloColor(forGame game: String) -> Color {
        guard let elo = gameElos[game] else { return .gray }
        
        switch elo {
        case 0...999:
            return .brown
        case 1000...1499:
            return .gray
        case 1500...1999:
            return .yellow
        case 2000...2499:
            return .blue
        default:
            return .purple
        }
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
            let gameElos = data["GameELOs"] as? [String: Double]
        else {
            return nil
        }
        
        let formattedGames = games.compactMap { game -> (String, String)? in
            guard let name = game["nombre"], let rank = game["rango"] else { return nil }
            return (name, rank)
        }
        
        var user = User(
            name: name,
            age: age,
            gender: gender,
            description: description,
            games: formattedGames,
            profileImage: profileImage
        )
        
        // Actualizar los ELOs desde la API
        for (game, elo) in gameElos {
            user.gameElos[game] = elo
        }
        
        return user
    }
} 