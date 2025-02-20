import SwiftUI

struct MainScreenView: View {
    @StateObject private var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                ZStack {
                    HStack {
                        Spacer()
                        Text("Team")
                            .font(.system(size: 28, weight: .bold)) +
                        Text("UP")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                        Spacer()
                    }
                }
                .padding(.vertical, 8)
                .background(Color(.systemBackground))
                .shadow(color: .black.opacity(0.2), radius: 5, y: 2)
                
                // Lista de usuarios
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.users) { user in
                            VStack(alignment: .leading) {
                                HStack(spacing: 12) {
                                    Image(user.profileImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        NavigationLink(destination: UserDetailView(user: user)) {
                                            Text(user.name)
                                                .font(.system(size: 18, weight: .semibold))
                                                .foregroundColor(.primary)
                                        }
                                        
                                        Text("\(user.age) años • \(user.gender)")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                    }
                                }
                                
                                Text(user.description)
                                    .font(.system(size: 14))
                                    .foregroundColor(.primary)
                                    .padding(.top, 8)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(user.games, id: \.0) { game in
                                        HStack {
                                            Text(game.0)
                                                .font(.system(size: 14, weight: .medium))
                                            Text("•")
                                                .foregroundColor(.gray)
                                            Text(game.1)
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                .padding(.top, 8)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
                        }
                    }
                    .padding()
                }
                .background(Color(.systemGray6))
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
} 
