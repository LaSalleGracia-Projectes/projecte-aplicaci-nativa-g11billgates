import SwiftUI

struct MainScreenView: View {
    @StateObject private var viewModel = MainScreenViewModel()
    
    var body: some View {
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
            
            Spacer()
            
            // Card Stack or Message
            ZStack {
                if viewModel.currentIndex < viewModel.users.count {
                    CardView(user: viewModel.users[viewModel.currentIndex]) {
                        withAnimation(.spring()) {
                            viewModel.likeUser()
                        }
                    } onDislike: {
                        withAnimation(.spring()) {
                            viewModel.dislikeUser()
                        }
                    }
                    .transition(AnyTransition.asymmetric(
                        insertion: .opacity,
                        removal: .opacity
                    ))
                    .id(viewModel.currentIndex) // Forzar la recreación de la vista
                } else {
                    Text("Ya no quedan usuarios que mostrar, inténtalo más tarde")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.gray)
                        .padding()
                        .multilineTextAlignment(.center)
                }
            }
            
            Spacer()
        }
        .background(Color(.systemGray6))
    }
}

struct CardView: View {
    let user: User
    let onLike: () -> Void
    let onDislike: () -> Void
    
    @State private var offset = CGSize.zero
    @State private var color = Color.black
    
    private let cardWidth = UIScreen.main.bounds.width - 40
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Imagen del usuario
                Image(user.profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: cardWidth, height: cardWidth)
                    .clipped()
                
                // Información del usuario
                VStack(alignment: .leading, spacing: 15) {
                    // Nombre y edad
                    HStack(spacing: 8) {
                        Text(user.name)
                            .font(.system(size: 26, weight: .bold))
                        Text("\(user.age)")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 15)
                    .padding(.leading, 15)
                    
                    // Juegos y rangos
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(user.games, id: \.0) { game in
                            HStack(spacing: 8) {
                                Text(game.0)
                                    .font(.system(size: 17, weight: .medium))
                                Text("•")
                                    .foregroundColor(.gray)
                                Text(game.1)
                                    .font(.system(size: 17))
                                    .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemGray6))
                            )
                        }
                    }
                    .padding(.leading, 15)
                    .padding(.bottom, 15)
                }
                .frame(width: cardWidth)
                .background(Color(.systemBackground))
            }
            .frame(width: cardWidth)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 8)
            .offset(x: offset.width, y: 0)
            .rotationEffect(.degrees(Double(offset.width / 40)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                        withAnimation {
                            color = offset.width > 0 ? .green : .red
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            if offset.width > 120 {
                                offset.width = 500
                                onLike()
                            } else if offset.width < -120 {
                                offset.width = -500
                                onDislike()
                            } else {
                                offset = .zero
                                color = .black
                            }
                        }
                    }
            )
            
            // Indicadores de Like/Dislike
            HStack {
                Text("NOPE")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.red, lineWidth: 2)
                    )
                    .rotationEffect(.degrees(-30))
                    .opacity(offset.width < -20 ? 1 : 0)
                
                Spacer()
                
                Text("LIKE")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(red: 0.9, green: 0.3, blue: 0.2), lineWidth: 2)
                    )
                    .rotationEffect(.degrees(30))
                    .opacity(offset.width > 20 ? 1 : 0)
            }
            .foregroundColor(color)
            .padding(.horizontal, 40)
            .padding(.top, 40)
        }
    }
}

#Preview {
    MainScreenView()
} 
