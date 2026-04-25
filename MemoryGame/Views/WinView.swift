//
//  WinView.swift
//  MemoryGame
//
//  Created by Alyaa on 4/25/26.
//

import SwiftUI

struct WinView: View {
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [Color.indigo.opacity(0.9), Color.purple.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 40) {

                Spacer()

                // ── Trophy ──
                VStack(spacing: 16) {
                    Text("🎉")
                        .font(.system(size: 80))

                    Text("You Won!")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)

                    Text("Great memory!")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.7))
                }

                // ── Score Card ──
                VStack(spacing: 0) {
                    ScoreRow(
                        icon: "hand.tap.fill",
                        label: "Total Moves",
                        value: "\(viewModel.moves)"
                    )
                    Divider().overlay(Color.indigo.opacity(0.1))

                    ScoreRow(
                        icon: "clock.fill",
                        label: "Time",
                        value: viewModel.formattedTime
                    )
                    Divider().overlay(Color.indigo.opacity(0.1))

                    ScoreRow(
                        icon: "star.fill",
                        label: "Score",
                        value: "\(viewModel.score)"
                    )
                    Divider().overlay(Color.indigo.opacity(0.1))

                    ScoreRow(
                        icon: "trophy.fill",
                        label: "Best Score",
                        value: "\(viewModel.bestScore)",
                        highlight: true
                    )
                }
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.1), radius: 10)
                .padding(.horizontal, 32)

                // ── Buttons ──
                VStack(spacing: 12) {

                    // Play again same difficulty
                    Button {
                        viewModel.restartGame()
                        dismiss()
                        dismiss()
                    } label: {
                        Text("Play Again 🎮")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.indigo)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
                    }

                    // Back to home
                    Button {
                        dismiss()
                        dismiss()
                    } label: {
                        Text("Change Difficulty")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(20)
                    }
                }
                .padding(.horizontal, 32)

                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

// ── Score Row Component ──
struct ScoreRow: View {
    let icon: String
    let label: String
    let value: String
    var highlight: Bool = false

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(highlight ? .yellow : .indigo)
                .frame(width: 24)
            Text(label)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .fontWeight(.bold)
                .foregroundColor(highlight ? .indigo : .primary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
}
