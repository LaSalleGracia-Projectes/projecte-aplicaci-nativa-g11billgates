import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(\.dismiss) var dismiss
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Apariencia")) {
                    Picker("Tema", selection: $isDarkMode) {
                        Text("Claro").tag(false)
                        Text("Oscuro").tag(true)
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Filtros de juego")) {
                    Toggle("Filtrar por rango", isOn: $viewModel.settings.filterByRank)
                }
                
                Section(header: Text("Filtros de edad")) {
                    HStack {
                        Text("Edad mínima: \(viewModel.settings.minAge)")
                        Spacer()
                        Stepper("", value: $viewModel.settings.minAge, in: 18...viewModel.settings.maxAge)
                    }
                    
                    HStack {
                        Text("Edad máxima: \(viewModel.settings.maxAge)")
                        Spacer()
                        Stepper("", value: $viewModel.settings.maxAge, in: viewModel.settings.minAge...100)
                    }
                }
                
                Section(header: Text("Filtros de género")) {
                    Picker("Mostrar", selection: $viewModel.settings.genderPreference) {
                        ForEach(Settings.GenderPreference.allCases) { preference in
                            Text(preference.rawValue).tag(preference)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Configuración")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        viewModel.saveSettings()
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
} 