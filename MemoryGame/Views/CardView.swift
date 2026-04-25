//
//  CardView.swift
//  MemoryGame
//
//  Created by Alyaa on 4/25/26.
//

import SwiftUI

struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            // ── Back of card ──
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [Color.indigo, Color.purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                .opacity(card.isFaceUp ? 0 : 1)

            // ── Front of card ──
            RoundedRectangle(cornerRadius: 16)
                .fill(card.isMatched ? Color.green.opacity(0.2) : Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            card.isMatched ? Color.green : Color.indigo.opacity(0.3),
                            lineWidth: 2
                        )
                )
                .opacity(card.isFaceUp ? 1 : 0)

            // ── Emoji ──
            Text(card.emoji)
                .font(.system(size: 36))
                .opacity(card.isFaceUp ? 1 : 0)
                .scaleEffect(card.isMatched ? 1.2 : 1.0)
                .animation(.spring(response: 0.3), value: card.isMatched)

            // ── Question mark on back ──
            Text("?")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white.opacity(0.6))
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            .degrees(card.isFaceUp ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.easeInOut(duration: 0.4), value: card.isFaceUp)
        .frame(height: 90)
    }
}
