//
//  MainScreenView.swift
//  TeamUP
//
//  Created by Marc Fernández on 7/2/25.
//

import SwiftUI

struct MainScreenView: View {
    @State private var cardOffset: CGSize = .zero
    @State private var lastCardOffset: CGSize = .zero
    
    var body: some View {
        VStack(spacing: 0) {
            // Header mejorado
            HStack {
                Spacer()
                Image(systemName: "gamecontroller.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 28)
                    .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                    .padding(.horizontal)
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                }
                .padding(.trailing, 20)
            }
            .frame(height: 50)
            .background(Color.black.opacity(0.3))
            
            // Contenido principal
            GeometryReader { geometry in
                ZStack {
                    // Fondo
                    Color.black.opacity(0.1)
                    
                    // Tarjeta principal
                    VStack {
                        ZStack {
                            // Tarjeta del usuario
                            VStack(spacing: 0) {
                                // Imagen del usuario con gradiente
                                ZStack(alignment: .bottom) {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: geometry.size.height * 0.6)
                                        .clipped()
                                        .background(Color.gray.opacity(0.3))
                                    
                                    // Gradiente sobre la imagen
                                    LinearGradient(
                                        gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                    .frame(height: 100)
                                }
                                
                                // Información del usuario mejorada
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        Text("Username, 25")
                                            .font(.title2)
                                            .bold()
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    
                                    HStack(spacing: 8) {
                                        Image(systemName: "gamecontroller")
                                            .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                                        Text("League of Legends")
                                            .font(.system(size: 16))
                                            .foregroundColor(.gray)
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15)
                                .background(Color.black.opacity(0.6))
                            }
                            .cornerRadius(20)
                            .shadow(radius: 8)
                            .offset(cardOffset)
                            .rotationEffect(.degrees(Double(cardOffset.width / 20)))
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        cardOffset = CGSize(
                                            width: gesture.translation.width + lastCardOffset.width,
                                            height: gesture.translation.height + lastCardOffset.height
                                        )
                                    }
                                    .onEnded { gesture in
                                        withAnimation(.spring()) {
                                            if abs(cardOffset.width) > 100 {
                                                cardOffset.width = cardOffset.width > 0 ? 500 : -500
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                    cardOffset = .zero
                                                }
                                            } else {
                                                cardOffset = .zero
                                            }
                                            lastCardOffset = .zero
                                        }
                                    }
                            )
                    
                            // Indicadores de like/dislike
                            if cardOffset.width > 60 {
                                LikeDislikeIndicator(text: "LIKE", color: Color(red: 0.9, green: 0.3, blue: 0.2))
                                    .offset(x: -50)
                            } else if cardOffset.width < -60 {
                                LikeDislikeIndicator(text: "NOPE", color: .red)
                                    .offset(x: 50)
                            }
                        }
                        
                        // Botones de acción reposicionados
                        HStack(spacing: 50) {
                            // Botón Dislike mejorado
                            ActionButton(
                                icon: "xmark",
                                color: .red,
                                action: { swipeCard(direction: .left) }
                            )
                            
                            // Botón Like mejorado
                            ActionButton(
                                icon: "heart.fill",
                                color: Color(red: 0.9, green: 0.3, blue: 0.2),
                                action: { swipeCard(direction: .right) }
                            )
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 60) // Espacio para la TabBar
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    enum SwipeDirection {
        case left, right
    }
    
    func swipeCard(direction: SwipeDirection) {
        withAnimation(.spring()) {
            cardOffset.width = direction == .right ? 500 : -500
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                cardOffset = .zero
            }
        }
    }
}

// Componentes auxiliares
struct LikeDislikeIndicator: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.title)
            .bold()
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(color, lineWidth: 4)
            )
            .foregroundColor(color)
            .rotationEffect(.degrees(-30))
    }
}

struct ActionButton: View {
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
                .padding(20)
                .background(color)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
    }
}

#Preview {
    MainScreenView()
}
