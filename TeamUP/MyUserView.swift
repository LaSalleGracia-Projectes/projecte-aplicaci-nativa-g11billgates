//
//  MyUserView.swift
//  TeamUP
//
//  Created by Marc Fernández on 7/2/25.
//

import SwiftUI

struct MyUserView: View {
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var selectedGames: Set<String> = []
    @State private var selectedGender: Gender = .male
    @State private var showingSettings = false
    @State private var selectedRanks: [Game: String] = [:]
    
    let games = ["Counter Strike", "League of Legends", "World of Warcraft", "Valorant"]
    
    enum Gender: String, CaseIterable {
        case male = "Hombre"
        case female = "Mujer"
    }
    
    enum Game: String, CaseIterable {
        case valorant = "Valorant"
        case cs = "Counter Strike 2"
        case lol = "League of Legends"
        case wow = "World of Warcraft"
        
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
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header igual que MainScreenView
            HStack {
                Spacer()
                
                Button(action: {
                    showingSettings = true
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                }
                .padding(.trailing, 20)
                .sheet(isPresented: $showingSettings) {
                    AjustesView()
                }
            }
            .overlay(
                HStack {
                    Text("Team")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white) +
                    Text("UP")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                }
            )
            .frame(height: 50)
            .background(
                Color.black.opacity(0.3)
                    .shadow(color: .black.opacity(0.2), radius: 5, y: 2)
            )
            
            // Contenido existente
            ScrollView {
                VStack(spacing: 20) {
                    // Imagen de perfil
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
                    
                    // Nombre
                    VStack(alignment: .leading) {
                        Text("Nombre")
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                        TextField("Tu nombre", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 5)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    
                    // Descripción
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
                    .padding(.vertical, 5)
                    
                    // Juegos y Rangos
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Juegos y Rangos")
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                        
                        ForEach(Game.allCases, id: \.self) { game in
                            VStack(alignment: .leading, spacing: 8) {
                                GameToggleButton(
                                    title: game.rawValue,
                                    isSelected: selectedGames.contains(game.rawValue),
                                    action: {
                                        if selectedGames.contains(game.rawValue) {
                                            selectedGames.remove(game.rawValue)
                                            selectedRanks.removeValue(forKey: game)
                                        } else {
                                            selectedGames.insert(game.rawValue)
                                            selectedRanks[game] = game.ranks[0]
                                        }
                                    }
                                )
                                
                                if selectedGames.contains(game.rawValue) {
                                    Picker("Rango", selection: Binding(
                                        get: { selectedRanks[game] ?? game.ranks[0] },
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
                    
                    Spacer()
                }
            }
        }
        .background(Color.black.opacity(0.1))
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
