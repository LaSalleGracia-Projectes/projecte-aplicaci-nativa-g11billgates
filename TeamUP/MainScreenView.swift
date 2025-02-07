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
            // Header
            HStack {
                Spacer()
                // Logo placeholder (reemplazar con tu imagen)
                Image(systemName: "gamecontroller.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.2))
                Spacer()
                
                // Botón de ajustes
                Button(action: {
                    // Acción para ajustes
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                }
                .padding(.trailing)
            }
            .frame(height: 60)
            .background(Color.black.opacity(0.2))
            
            // Card View
            ZStack {
                // Fondo
                Color.black.opacity(0.1)
                
                // Tarjeta principal
                VStack {
                    ZStack {
                        // Tarjeta del usuario
                        VStack(spacing: 0) {
                            // Imagen del usuario
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 400)
                                .clipped()
                                .background(Color.gray.opacity(0.3))
                            
                            // Información del usuario
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Username, 25")
                                        .font(.title2)
                                        .bold()
                                    Spacer()
                                }
                                
                                HStack {
                                    Image(systemName: "gamecontroller")
                                    Text("League of Legends")
                                        .font(.system(size: 16))
                                    Spacer()
                                }
                            }
                            .padding()
                            .background(Color.black.opacity(0.7))
                        }
                        .cornerRadius(15)
                        .shadow(radius: 5)
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
                                            // Swipe completo
                                            cardOffset.width = cardOffset.width > 0 ? 500 : -500
                                            // Aquí puedes agregar la lógica para like/dislike
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                cardOffset = .zero
                                            }
                                        } else {
                                            // Regresar a la posición original
                                            cardOffset = .zero
                                        }
                                        lastCardOffset = .zero
                                    }
                                }
                        )
                    }
                }
                .padding()
                
                // Botones de acción
                VStack {
                    Spacer()
                    HStack(spacing: 40) {
                        // Botón Dislike
                        Button(action: { swipeCard(direction: .left) }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.white)
                                .padding(20)
                                .background(Color.red.opacity(0.8))
                                .clipShape(Circle())
                        }
                        
                        // Botón Like
                        Button(action: { swipeCard(direction: .right) }) {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.white)
                                .padding(20)
                                .background(Color(red: 0.9, green: 0.3, blue: 0.2))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    enum SwipeDirection {
        case left, right
    }
    
    func swipeCard(direction: SwipeDirection) {
        withAnimation(.spring()) {
            cardOffset.width = direction == .right ? 500 : -500
            // Aquí puedes agregar la lógica para like/dislike
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                cardOffset = .zero
            }
        }
    }
}

#Preview {
    MainScreenView()
}
