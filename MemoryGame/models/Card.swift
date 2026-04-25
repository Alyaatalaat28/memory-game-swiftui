//
//  Card.swift
//  MemoryGame
//
//  Created by Alyaa on 4/25/26.
//
import Foundation

struct Card: Identifiable {
    let id = UUID()
    let emoji: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}
