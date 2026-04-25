//
//  GameView.swift
//  MemoryGame
//
//  Created by Alyaa on 4/25/26.
//

import SwiftUI

struct GameView: View {
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

            VStack(spacing: 0) {

                // ── Stats Bar ──
                HStack(spacing: 0) {

                    // Moves
                    StatItem(
                        icon: "hand.tap.fill",
                        value: "\(viewModel.moves)",
                        label: "Moves"
                    )

                    Divider()
                        .frame(height: 40)
                        .overlay(Color.white.opacity(0.3))

                    // Timer
                    StatItem(
                        icon: "clock.fill",
                        value: viewModel.formattedTime,
                        label: "Time"
                    )

                    Divider()
                        .frame(height: 40)
                        .overlay(Color.white.opacity(0.3))

                    // Pairs
                    StatItem(
                        icon: "square.grid.2x2.fill",
                        value: "\(viewModel.matchedPairs)/\(viewModel.totalPairs)",
                        label: "Pairs"
                    )
                }
                .padding(.vertical, 16)
                .background(Color.white.opacity(0.15))
                .cornerRadius(16)
                .padding(.horizontal, 24)
                .padding(.top, 16)

                // ── Card Grid ──
                ScrollView {
                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible(), spacing: 10),
                            count: viewModel.difficulty.columns
                        ),
                        spacing: 10
                    ) {
                        ForEach(Array(viewModel.cards.enumerated()), id: \.element.id) { index, card in
                            CardView(card: card)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.flipCard(at: index)
                                    }
                                }
                                .opacity(card.isMatched ? 0.6 : 1.0)
                        }
                    }
                    .padding(16)
                }

                // ── Restart Button ──
                Button {
                    viewModel.restartGame()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.clockwise")
                        Text("Restart")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(14)
                }
                .padding(.bottom, 24)
            }
        }
        .navigationTitle(viewModel.difficulty.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Home")
                    }
                    .foregroundColor(.white)
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.isGameWon) {
            WinView(viewModel: viewModel)
        }
    }
}

// ── Stat Item Component ──
struct StatItem: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                Text(value)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            Text(label)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
    }
}
