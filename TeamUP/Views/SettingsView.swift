import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $viewModel.notificationsEnabled) {
                    Text("Notificaciones")
                }
                
                Toggle(isOn: $viewModel.darkModeEnabled) {
                    Text("Modo Oscuro")
                }
            }
            .navigationTitle("Ajustes")
        }
    }
} 