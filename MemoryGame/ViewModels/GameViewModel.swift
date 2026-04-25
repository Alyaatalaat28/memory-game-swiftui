//
//  GameViewModel.swift
//  MemoryGame
//
//  Created by Alyaa on 4/25/26.
//

import Foundation
import Combine

@MainActor
class GameViewModel: ObservableObject {

    // ── Published State ──
    @Published var cards: [Card] = []
    @Published var moves: Int = 0
    @Published var matchedPairs: Int = 0
    @Published var timeElapsed: Int = 0
    @Published var isGameWon: Bool = false
    @Published var difficulty: Difficulty = .easy

    // ── Private ──
    private var firstFlippedIndex: Int? = nil
    private var isChecking: Bool = false
    private var timer: AnyCancellable? = nil

    // ── Best Score (persisted) ──
    @Published var bestScore: Int = UserDefaults.standard.integer(forKey: "bestScore")

    // All available emojis pool
    private let emojiPool = [
        "🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼",
        "🐨","🐯","🦁","🐮","🐸","🐵","🐔","🐧",
        "🐦","🦆","🦅","🦉","🦇","🐺","🐗","🐴",
        "🦄","🐝","🐛","🦋","🐌","🐞","🐜","🦟"
    ]

    // ── Computed ──
    var totalPairs: Int { difficulty.pairs }

    var score: Int {
        // Lower moves + less time = higher score
        let base = 1000
        let movePenalty = moves * 10
        let timePenalty = timeElapsed * 2
        return max(0, base - movePenalty - timePenalty)
    }

    // ─────────────────────────────────────────
    // MARK: - Game Setup
    // ─────────────────────────────────────────

    func startGame(difficulty: Difficulty) {
        self.difficulty = difficulty
        moves = 0
        matchedPairs = 0
        timeElapsed = 0
        isGameWon = false
        firstFlippedIndex = nil
        isChecking = false

        // Pick random emojis and create pairs
        let selected = Array(emojiPool.shuffled().prefix(difficulty.pairs))
        let paired = (selected + selected).shuffled()
        cards = paired.map { Card(emoji: $0) }

        startTimer()
    }

    func restartGame() {
        stopTimer()
        startGame(difficulty: difficulty)
    }

    // ─────────────────────────────────────────
    // MARK: - Card Flip Logic
    // ─────────────────────────────────────────

    func flipCard(at index: Int) {
        // Guard against invalid flips
        guard !isChecking else { return }
        guard !cards[index].isMatched else { return }
        guard !cards[index].isFaceUp else { return }

        cards[index].isFaceUp = true

        if let first = firstFlippedIndex {
            // Second card flipped — check for match
            moves += 1
            isChecking = true
            checkMatch(firstIndex: first, secondIndex: index)
            firstFlippedIndex = nil
        } else {
            // First card flipped — wait for second
            firstFlippedIndex = index
        }
    }

    private func checkMatch(firstIndex: Int, secondIndex: Int) {
        if cards[firstIndex].emoji == cards[secondIndex].emoji {
            // Match found
            Task {
                try? await Task.sleep(nanoseconds: 500_000_000)
                cards[firstIndex].isMatched = true
                cards[secondIndex].isMatched = true
                matchedPairs += 1
                isChecking = false
                checkWin()
            }
        } else {
            // No match — flip back
            Task {
                try? await Task.sleep(nanoseconds: 800_000_000)
                cards[firstIndex].isFaceUp = false
                cards[secondIndex].isFaceUp = false
                isChecking = false
            }
        }
    }

    private func checkWin() {
        if matchedPairs == totalPairs {
            stopTimer()
            isGameWon = true
            saveBestScore()
        }
    }

    // ─────────────────────────────────────────
    // MARK: - Timer
    // ─────────────────────────────────────────

    private func startTimer() {
        stopTimer()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.timeElapsed += 1
            }
    }

    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }

    // ─────────────────────────────────────────
    // MARK: - Best Score
    // ─────────────────────────────────────────

    private func saveBestScore() {
        if bestScore == 0 || score > bestScore {
            bestScore = score
            UserDefaults.standard.set(bestScore, forKey: "bestScore")
        }
    }

    // Format time as mm:ss
    var formattedTime: String {
        let minutes = timeElapsed / 60
        let seconds = timeElapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
