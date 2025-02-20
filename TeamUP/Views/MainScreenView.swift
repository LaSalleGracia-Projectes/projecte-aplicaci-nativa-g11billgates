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
            
            // Card Stack
            ZStack {
                ForEach(viewModel.users.indices.reversed(), id: \.self) { index in
                    if index >= viewModel.currentIndex {
                        CardView(user: viewModel.users[index]) {
                            withAnimation {
                                viewModel.likeUser()
                            }
                        } onDislike: {
                            withAnimation {
                                viewModel.dislikeUser()
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 20)
            
            // Action Buttons
            HStack(spacing: 60) {
                Button(action: {
                    withAnimation {
                        let lastCard = viewModel.users[viewModel.currentIndex]
                        CardView(user: lastCard) { } onDislike: { }
                            .offset(x: -500)
                            .rotationEffect(.degrees(-20))
                        viewModel.dislikeUser()
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color.red)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                
                Button(action: {
                    withAnimation {
                        let lastCard = viewModel.users[viewModel.currentIndex]
                        CardView(user: lastCard) { } onDislike: { }
                            .offset(x: 500)
                            .rotationEffect(.degrees(20))
                        viewModel.likeUser()
                    }
                }) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color(red: 0.9, green: 0.3, blue: 0.2))
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
            }
            .padding(.bottom, 30)
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
                VStack(spacing: 15) {
                    // Nombre y edad
                    HStack(spacing: 8) {
                        Spacer()
                        Text(user.name)
                            .font(.system(size: 26, weight: .bold))
                        Text("\(user.age)")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.top, 15)
                    
                    // Juegos y rangos
                    VStack(spacing: 12) {
                        ForEach(user.games, id: \.0) { game in
                            HStack {
                                Spacer()
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
                                Spacer()
                            }
                        }
                    }
                    .padding(.bottom, 15)
                }
                .frame(width: cardWidth)
                .padding(.horizontal, 25)
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
                        withAnimation {
                            if offset.width > 120 {
                                offset.width = 500
                                onLike()
                            } else if offset.width < -120 {
                                offset.width = -500
                                onDislike()
                            } else {
                                offset = .zero
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
