import SwiftUI

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var filteredUsers: [User] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let baseURL = "http://localhost:3000"
    
    init() {
        loadUsers()
    }
    
    func loadUsers() {
        isLoading = true
        error = nil
        
        guard let url = URL(string: "\(baseURL)/usuarios") else {
            error = "URL inválida"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.error = error.localizedDescription
                    return
                }
                
                guard let data = data else {
                    self?.error = "No se recibieron datos"
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                        self?.users = json.compactMap { User.fromAPI($0) }
                        self?.filteredUsers = self?.users ?? []
                    }
                } catch {
                    self?.error = "Error al decodificar los datos: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    func filterUsersByElo(currentUserElo: Int, range: Int = 300) {
        isLoading = true
        error = nil
        
        guard let url = URL(string: "\(baseURL)/usuarios/filtrados?eloUsuario=\(currentUserElo)&rangoPermitido=\(range)") else {
            error = "URL inválida"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.error = error.localizedDescription
                    return
                }
                
                guard let data = data else {
                    self?.error = "No se recibieron datos"
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                        self?.filteredUsers = json.compactMap { User.fromAPI($0) }
                    }
                } catch {
                    self?.error = "Error al decodificar los datos: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    func updateUserElo(userId: Int, newElo: Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/usuarios/\(userId)/elo") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["nuevoElo": newElo]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if error == nil,
                   let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 200 {
                    if let index = self?.users.firstIndex(where: { $0.id == userId }) {
                        self?.users[index].elo = newElo
                    }
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }.resume()
    }
} 
