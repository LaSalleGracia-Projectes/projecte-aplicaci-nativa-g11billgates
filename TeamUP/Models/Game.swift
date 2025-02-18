import Foundation

enum Game: String, CaseIterable {
    case valorant = "Valorant"
    case cs = "Counter Strike 2"
    case lol = "League of Legends"
    case wow = "World of Warcraft"
    case dota = "Dota 2"
    
    var ranks: [String] {
        switch self {
        case .valorant:
            return ["Sin Rango", "Hierro", "Bronce", "Plata", "Oro", "Platino", "Diamante", "Ascendente", "Inmortal", "Radiante"]
        case .cs:
            return ["Sin Rango", "Silver 1-4", "Gold Nova 1-4", "Master Guardian 1-2", "Master Guardian Elite", "Distinguished Master Guardian", "Legendary Eagle", "Legendary Eagle Master", "Supreme Master First Class", "Global Elite"]
        case .lol:
            return ["Sin Rango", "Hierro", "Bronce", "Plata", "Oro", "Platino", "Esmeralda", "Diamante", "Maestro", "Gran Maestro", "Retador"]
        case .wow:
            return ["Sin Rango", "300-1200", "1200-2000", "2000-2400", "2400-3500+"]
        case .dota:
            return ["Sin Rango", "Heraldo", "Guardián", "Cruzado", "Arconte", "Leyenda", "Ancestral", "Divino", "Inmortal"]
        }
    }
} 