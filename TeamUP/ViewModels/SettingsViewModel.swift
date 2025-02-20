import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var notificationsEnabled: Bool = true
    @Published var darkModeEnabled: Bool = false
    
    func toggleNotifications() {
        notificationsEnabled.toggle()
    }
    
    func toggleDarkMode() {
        darkModeEnabled.toggle()
    }
} 