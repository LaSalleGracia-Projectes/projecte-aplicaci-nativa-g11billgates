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
    @AppStorage("filterBySkill") private var filterBySkill = true
    
    @State private var selectedGender: Gender = .all
    @State private var minAge: Double = 18
    @State private var maxAge: Double = 50
    
    enum Gender: String, CaseIterable {
        case all = "Todos"
        case male = "Hombre"
        case female = "Mujer"
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Sección de Filtros
                Section(header: Text("Filtros").foregroundColor(.gray)) {
                    Toggle("Filtrar por nivel de habilidad", isOn: $filterBySkill)
                }
                .onChange(of: filterBySkill) { newValue in
                    // Aquí puedes añadir lógica adicional cuando cambie el filtro
                }
                
                // Sección de Filtros de Género
                Section(header: Text("Género").foregroundColor(.gray)) {
                    Picker("Mostrar", selection: $selectedGender) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Sección de Filtros de Edad
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
                    Image(systemName: "arrowshape.turn.up.backward")
                        .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                        .font(.system(size: 20, weight: .bold))
                }
            )
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AjustesView()
    }
}
