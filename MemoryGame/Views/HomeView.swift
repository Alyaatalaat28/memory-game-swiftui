//
//  HomeView.swift
//  MemoryGame
//
//  Created by Alyaa on 4/25/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var selectedDifficulty: Difficulty = .easy
    @State private var navigateToGame = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                LinearGradient(
                    colors: [Color.indigo.opacity(0.9), Color.purple.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 48) {

                    Spacer()

                    // ── Title ──
                    VStack(spacing: 8) {
                        Text("🃏")
                            .font(.system(size: 72))
                        Text("Memory Game")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                        Text("Find all matching pairs")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }

                    // ── Best Score ──
                    if viewModel.bestScore > 0 {
                        HStack(spacing: 8) {
                            Image(systemName: "trophy.fill")
                                .foregroundColor(.yellow)
                            Text("Best Score: \(viewModel.bestScore)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.white.opacity(0.15))
                        .clipShape(Capsule())
                    }

                    // ── Difficulty Selector ──
                    VStack(spacing: 16) {
                        Text("SELECT DIFFICULTY")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white.opacity(0.6))
                            .kerning(2)

                        VStack(spacing: 12) {
                            ForEach(Difficulty.allCases, id: \.self) { difficulty in
                                Button {
                                    withAnimation(.spring()) {
                                        selectedDifficulty = difficulty
                                    }
                                } label: {
                                    HStack {
                                        Text(difficulty.emoji)
                                            .font(.title2)
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(difficulty.rawValue)
                                                .font(.headline)
                                                .foregroundColor(
                                                    selectedDifficulty == difficulty
                                                    ? .indigo : .white
                                                )
                                            Text("\(difficulty.pairs) pairs · \(difficulty.columns) columns")
                                                .font(.caption)
                                                .foregroundColor(
                                                    selectedDifficulty == difficulty
                                                    ? .indigo.opacity(0.7) : .white.opacity(0.6)
                                                )
                                        }
                                        Spacer()
                                        if selectedDifficulty == difficulty {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.indigo)
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 14)
                                    .background(
                                        selectedDifficulty == difficulty
                                        ? Color.white
                                        : Color.white.opacity(0.15)
                                    )
                                    .cornerRadius(16)
                                }
                            }
                        }
                        .padding(.horizontal, 32)
                    }

                    // ── Start Button ──
                    Button {
                        viewModel.startGame(difficulty: selectedDifficulty)
                        navigateToGame = true
                    } label: {
                        Text("Start Game 🎮")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.indigo)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
                    }
                    .padding(.horizontal, 32)

                    Spacer()
                }
            }
            .navigationDestination(isPresented: $navigateToGame) {
                GameView(viewModel: viewModel)
            }
        }
    }
}
