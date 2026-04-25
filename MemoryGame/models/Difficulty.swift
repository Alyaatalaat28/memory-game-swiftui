//
//  Difficulty.swift
//  MemoryGame
//
//  Created by Alyaa on 4/25/26.
//

import Foundation

enum Difficulty: String, CaseIterable {
    case easy   = "Easy"
    case medium = "Medium"
    case hard   = "Hard"

    var pairs: Int {
        switch self {
        case .easy:   return 6   // 12 cards
        case .medium: return 10  // 20 cards
        case .hard:   return 15  // 30 cards
        }
    }

    var columns: Int {
        switch self {
        case .easy:   return 3
        case .medium: return 4
        case .hard:   return 5
        }
    }

    var emoji: String {
        switch self {
        case .easy:   return "😊"
        case .medium: return "🔥"
        case .hard:   return "💀"
        }
    }
}
