//
//  AjustesView.swift
//  TeamUP
//
//  Created by Marc Fernández on 7/2/25.
//

import SwiftUI

struct AjustesView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isDarkMode") private var isDarkMode = true
    
    @State private var selectedGender: Gender = .all
    @State private var minAge: Double = 18
    @State private var maxAge: Double = 50
    @State private var selectedGame: Game = .lol
    @State private var selectedRank: String = ""
    
    enum Gender: String, CaseIterable {
        case all = "Todos"
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
        NavigationView {
            Form {
                // Sección de Filtros de Género
                Section(header: Text("Género").foregroundColor(.gray)) {
                    Picker("Mostrar", selection: $selectedGender) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Sección de Filtros de Edad mejorada
                Section(header: Text("Rango de Edad").foregroundColor(.gray)) {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("Edad mínima: \(Int(minAge))")
                                .foregroundColor(.gray)
                            Slider(value: $minAge, in: 18...maxAge)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Edad máxima: \(Int(maxAge))")
                                .foregroundColor(.gray)
                            Slider(value: $maxAge, in: minAge...100)
                        }
                    }
                    .padding(.vertical, 5)
                }
                
                // Sección de Filtros de Juego mejorada
                Section(header: Text("Juego y Rango").foregroundColor(.gray)) {
                    Picker("Juego", selection: $selectedGame) {
                        ForEach(Game.allCases, id: \.self) { game in
                            Text(game.rawValue).tag(game)
                        }
                    }
                    
                    Picker("Rango Mínimo", selection: $selectedRank) {
                        ForEach(selectedGame.ranks, id: \.self) { rank in
                            Text(rank).tag(rank)
                        }
                    }
                }
                
                // Sección de Apariencia
                Section(header: Text("Apariencia").foregroundColor(.gray)) {
                    Toggle("Modo Oscuro", isOn: $isDarkMode)
                }
            }
            .navigationTitle("Ajustes")
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                        .font(.system(size: 20, weight: .bold))
                }
            )
            .onChange(of: selectedGame) { newGame in
                // Resetear el rango seleccionado cuando cambia el juego
                selectedRank = newGame.ranks[0]
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AjustesView()
    }
}
