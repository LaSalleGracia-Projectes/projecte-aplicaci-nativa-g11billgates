import Foundation

struct User: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let gender: String
    let description: String
    let games: [(String, String)]
    let profileImage: String
} 