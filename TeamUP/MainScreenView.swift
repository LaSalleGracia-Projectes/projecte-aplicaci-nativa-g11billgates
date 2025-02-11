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
    @State private var showingSettings = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header mejorado
            HStack {
                Spacer()
                
                Button(action: {
                    showingSettings = true
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.primary)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                }
                .padding(.trailing, 20)
            }
            .overlay(
                HStack {
                    Text("Team")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                    Text("UP")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                }
            )
            .frame(height: 50)
            .background(Color(.systemBackground))
            .shadow(color: .black.opacity(0.2), radius: 5, y: 2)
            .sheet(isPresented: $showingSettings) {
                AjustesView()
            }
            
            // Contenido principal
            GeometryReader { geometry in
                ZStack {
                    // Fondo con gradiente sutil
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.1),
                            Color(red: 0.9, green: 0.3, blue: 0.2).opacity(0.05)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                    // Tarjeta principal
                    VStack {
                        ZStack {
                            // Tarjeta del usuario con mejor sombra
                            VStack(spacing: 0) {
                                // Imagen del usuario
                                ZStack {
                                    Image("DwarfTestIcon")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: geometry.size.height * 0.6)
                                        .clipped()
                                }
                                
                                // Información del usuario mejorada
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text("Username, 25")
                                            .font(.title2)
                                            .bold()
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack(spacing: 8) {
                                            Image(systemName: "gamecontroller")
                                                .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                                            Text("League of Legends")
                                                .font(.system(size: 16))
                                                .foregroundColor(.primary.opacity(0.7))
                                            Text("•")
                                                .foregroundColor(.primary.opacity(0.7))
                                            Text("Diamante")
                                                .font(.system(size: 16))
                                                .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                                            Spacer()
                                        }
                                        
                                        HStack(spacing: 8) {
                                            Image(systemName: "gamecontroller")
                                                .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                                            Text("World of Warcraft")
                                                .font(.system(size: 16))
                                                .foregroundColor(.primary.opacity(0.7))
                                            Text("•")
                                                .foregroundColor(.primary.opacity(0.7))
                                            Text("2400+")
                                                .font(.system(size: 16))
                                                .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                                            Spacer()
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 6)
                                .background(Color(.systemBackground).opacity(0.9))
                            }
                            .background(Color(.systemGray4))
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
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
                                LikeDislikeIndicator(text: "LETS PLAY!", color: Color(red: 0.9, green: 0.3, blue: 0.2))
                                    .offset(x: -50)
                            } else if cardOffset.width < -60 {
                                LikeDislikeIndicator(text: "NAH", color: .red)
                                    .offset(x: 50)
                            }
                        }
                        
                        // Botones de acción reposicionados más cerca
                        HStack(spacing: 50) {
                            // Botón Dislike mejorado
                            ActionButton(
                                icon: "xmark",
                                color: .red,
                                action: { swipeCard(direction: .left) }
                            )
                            
                            // Botón Like mejorado
                            ActionButton(
                                icon: "gamecontroller",
                                color: Color(red: 0.9, green: 0.3, blue: 0.2),
                                action: { swipeCard(direction: .right) }
                            )
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 30)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
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
                .background(
                    color.opacity(0.9)
                        .shadow(color: .black.opacity(0.2), radius: 5)
                )
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: color.opacity(0.3), radius: 8, x: 0, y: 4)
        }
    }
}

#Preview {
    MainScreenView()
}
