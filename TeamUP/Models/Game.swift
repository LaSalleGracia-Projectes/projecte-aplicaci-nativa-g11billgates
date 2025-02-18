import Foundation

enum Game: String, CaseIterable {
    case leagueOfLegends = "League of Legends"
    case worldOfWarcraft = "World of Warcraft"
    case valorant = "Valorant"
    case csgo = "CS:GO"
    case dota2 = "Dota 2"
    
    var ranks: [String] {
        switch self {
        case .leagueOfLegends:
            return ["Hierro", "Bronce", "Plata", "Oro", "Platino", "Diamante", "Master", "GrandMaster", "Challenger"]
        case .worldOfWarcraft:
            return ["1400-1600", "1600-1800", "1800-2000", "2000-2200", "2200-2400", "2400+"]
        case .valorant:
            return ["Hierro", "Bronce", "Plata", "Oro", "Platino", "Diamante", "Inmortal", "Radiante"]
        case .csgo:
            return ["Plata 1-4", "Plata Élite", "Oro 1-4", "MG1-MGE", "DMG", "LE-LEM", "Supremo", "Global"]
        case .dota2:
            return ["Heraldo", "Guardián", "Cruzado", "Arconte", "Leyenda", "Ancestral", "Divino", "Inmortal"]
        }
    }
} 