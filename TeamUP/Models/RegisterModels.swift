enum Gender {
    case male
    case female
}

enum SearchPreference {
    case all
    case male
    case female
}

struct GameRank {
    let game: Game
    let rank: String
} 