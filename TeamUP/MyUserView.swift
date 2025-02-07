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
    
    let games = ["Counter Strike", "League of Legends", "World of Warcraft", "Valorant"]
    
    enum Gender: String, CaseIterable {
        case male = "Hombre"
        case female = "Mujer"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header igual que MainScreenView
            HStack {
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                }
                .padding(.trailing, 20)
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
                    
                    // Juegos
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Juegos favoritos")
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                        
                        ForEach(games, id: \.self) { game in
                            GameToggleButton(
                                title: game,
                                isSelected: selectedGames.contains(game),
                                action: {
                                    if selectedGames.contains(game) {
                                        selectedGames.remove(game)
                                    } else {
                                        selectedGames.insert(game)
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    
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
