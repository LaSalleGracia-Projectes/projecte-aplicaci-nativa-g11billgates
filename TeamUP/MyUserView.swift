//
//  MyUserView.swift
//  TeamUP
//
//  Created by Marc Fernández on 7/2/25.
//

import SwiftUI
import Foundation // Asegúrate de importar el módulo correcto si es necesario
// Importa el archivo donde está definido el enum Game

struct MyUserView: View {
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var selectedGames: [Game] = []
    @State private var selectedGender: Gender = .male
    @State private var showingSettings = false
    @State private var selectedRanks: [Game: String] = [:]
    
    let games = ["Counter Strike", "League of Legends", "World of Warcraft", "Valorant"] //Juegos a los que juega el usuaio, depende de cual marque se filtrará para otros users.
    
    enum Gender: String, CaseIterable {
        case male = "Hombre"
        case female = "Mujer"
    } //Generos, se puede filtrar por ellos
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Spacer()
                
                Button(action: {
                    showingSettings = true
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.primary)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                }
                .padding(.trailing, 20)
            }
            .overlay(
                HStack(spacing: 0) {
                    Text("Team")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary) +
                    Text("UP")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                }
            )
            .frame(height: 50)
            .background(Color(.systemBackground))
            .shadow(color: .black.opacity(0.2), radius: 5, y: 2)
            .sheet(isPresented: $showingSettings) {
                AjustesView()
            }
            
            // Contenido del perfil
            ScrollView {
                VStack(spacing: 20) {
                    // La imagen redondita de perfil
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 100, height: 100)
                        
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                        
                        Circle()
                            .stroke(Color(red: 0.9, green: 0.3, blue: 0.2), lineWidth: 3)
                            .frame(width: 100, height: 100)
                        
                        Button(action: {
                            // Acción para cambiar la foto
                        }) {
                            Image(systemName: "camera.fill")
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color(red: 0.9, green: 0.3, blue: 0.2))
                                .clipShape(Circle())
                        }
                        .offset(x: 35, y: 35)
                    }
                    .padding(.top, 10)
                    
                    // Campos de entrada
                    VStack(alignment: .leading) {
                        Text("Nombre")
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                        TextField("Tu nombre", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 5)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("Descripción")
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                        TextEditor(text: $description)
                            .frame(height: 60)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                            .padding(.horizontal, 5)
                    }
                    .padding(.horizontal)
                    
                    // Juegos y Rangos
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Juegos y Rangos")
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                        
                        ForEach(Game.allCases, id: \.self) { game in
                            VStack(alignment: .leading, spacing: 8) {
                                Button(action: {
                                    if selectedGames.contains(game) {
                                        selectedGames.removeAll { $0 == game }
                                        selectedRanks.removeValue(forKey: game)
                                    } else {
                                        selectedGames.append(game)
                                        selectedRanks[game] = game.ranks.first ?? "Sin Rango"
                                    }
                                }) {
                                    HStack {
                                        Text(game.rawValue)
                                        Spacer()
                                        if selectedGames.contains(game) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(selectedGames.contains(game) ? Color.blue : Color.gray.opacity(0.2)))
                                }
                                
                                if selectedGames.contains(game) {
                                    Picker("Rango", selection: Binding(
                                        get: { selectedRanks[game] ?? game.ranks.first ?? "Sin Rango" },
                                        set: { selectedRanks[game] = $0 }
                                    )) {
                                        ForEach(game.ranks, id: \.self) { rank in
                                            Text(rank).tag(rank)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Género
                    VStack(alignment: .leading) {
                        Text("Género")
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                        
                        Picker("Género", selection: $selectedGender) {
                            ForEach(Gender.allCases, id: \.self) { gender in
                                Text(gender.rawValue).tag(gender)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal, 5)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                }
            }
            .background(Color.black.opacity(0.1))
        }
    }
}

struct GameToggleButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(isSelected ? .white : .primary)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 15)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? Color(red: 0.9, green: 0.3, blue: 0.2) : Color.gray.opacity(0.2))
            )
        }
        .padding(.vertical, 1)
    }
}

#Preview {
    MyUserView()
}
