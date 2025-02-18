import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentPage = 0
    
    // Primera página
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    // Segunda página
    @State private var selectedGames: Set<String> = []
    @State private var selectedRanks: [Game: String] = [:]
    @State private var filterByRank = false
    @State private var profileImage: Image?
    @State private var isDarkMode = false
    @State private var description = ""
    @State private var age = 18
    @State private var ageRange = 18.0...99.0
    @State private var genderPreference = "Ambos"
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentPage) {
                // Primera página - Información básica
                VStack(spacing: 25) {
                    Text("Información básica")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    
                    VStack(spacing: 20) {
                        // Nombre
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Nombre")
                                .foregroundColor(.gray)
                            TextField("Tu nombre", text: $name)
                                .textFieldStyle(CustomTextFieldStyle())
                        }
                        
                        // Email
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .foregroundColor(.gray)
                            TextField("tu@email.com", text: $email)
                                .textFieldStyle(CustomTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                        }
                        
                        // Contraseña
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Contraseña")
                                .foregroundColor(.gray)
                            SecureField("••••••••", text: $password)
                                .textFieldStyle(CustomTextFieldStyle())
                        }
                        
                        // Confirmar Contraseña
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Confirmar Contraseña")
                                .foregroundColor(.gray)
                            SecureField("••••••••", text: $confirmPassword)
                                .textFieldStyle(CustomTextFieldStyle())
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Button(action: {
                        withAnimation {
                            currentPage = 1
                        }
                    }) {
                        Text("Siguiente")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(red: 0.9, green: 0.3, blue: 0.2))
                            .cornerRadius(25)
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                }
                .tag(0)
                
                // Segunda página - Preferencias
                VStack(spacing: 25) {
                    Text("Preferencias")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            // Juegos y rangos
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Tus juegos")
                                    .font(.headline)
                                    .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                                
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
                                        }
                                    }
                                }
                            }
                            
                            // Filtrar por rango
                            Toggle("Filtrar por rango", isOn: $filterByRank)
                                .tint(Color(red: 0.9, green: 0.3, blue: 0.2))
                            
                            // Modo oscuro
                            Toggle("Modo oscuro", isOn: $isDarkMode)
                                .tint(Color(red: 0.9, green: 0.3, blue: 0.2))
                            
                            // Descripción
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Descripción (opcional)")
                                    .foregroundColor(.gray)
                                TextEditor(text: $description)
                                    .frame(height: 100)
                                    .padding(8)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                            }
                            
                            // Edad
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Edad: \(age)")
                                    .foregroundColor(.gray)
                                Slider(value: .init(get: { Double(age) },
                                                  set: { age = Int($0) }),
                                       in: 18...99,
                                       step: 1)
                                    .tint(Color(red: 0.9, green: 0.3, blue: 0.2))
                            }
                            
                            // Rango de edad para filtrar
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Filtrar por edad: \(Int(ageRange.lowerBound))-\(Int(ageRange.upperBound))")
                                    .foregroundColor(.gray)
                                RangeSlider(range: $ageRange, in: 18.0...99.0)
                            }
                            
                            // Preferencia de género
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Mostrar")
                                    .foregroundColor(.gray)
                                Picker("Mostrar", selection: $genderPreference) {
                                    Text("Ambos").tag("Ambos")
                                    Text("Hombres").tag("Hombres")
                                    Text("Mujeres").tag("Mujeres")
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            // Botón de registro
                            Button(action: {
                                // Aquí iría la lógica de registro
                                dismiss()
                            }) {
                                Text("Crear cuenta")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color(red: 0.9, green: 0.3, blue: 0.2))
                                    .cornerRadius(25)
                            }
                            .padding(.top)
                        }
                        .padding(.horizontal, 30)
                    }
                }
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .navigationBarItems(leading: Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
            })
        }
    }
}

#Preview {
    RegisterView()
}
