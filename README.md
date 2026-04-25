# 🃏 Memory Game

A fun and beautiful memory card matching game built with SwiftUI.
Built as a learning project to explore Swift and SwiftUI concepts.

## Features

- 3 difficulty levels (Easy, Medium, Hard)
- Smooth 3D card flip animation
- Move counter and timer
- Score calculation
- Best score persistence
- Clean gradient UI design

## Screens

- **Home** — difficulty selector and best score
- **Game** — card grid with stats bar
- **Win** — score summary and play again
  
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-25 at 12 13 48" src="https://github.com/user-attachments/assets/001abc86-daeb-432a-823c-61edfac9cf06" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-25 at 12 14 51" src="https://github.com/user-attachments/assets/0732866f-27af-4767-b684-207c9da3cf46" />

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-25 at 12 15 22" src="https://github.com/user-attachments/assets/bdc2924b-d81b-4910-9e01-dc8d90dc62e9" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-25 at 12 14 12" src="https://github.com/user-attachments/assets/12c5b429-bff5-456e-b211-506d45caabc7" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-25 at 12 14 29" src="https://github.com/user-attachments/assets/ba184302-b411-4881-9dd4-ce3a88187929" />

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-25 at 12 14 39" src="https://github.com/user-attachments/assets/617c0daa-9a31-417f-a314-c78648a0f43d" />

## Concepts Learned

- `@StateObject` and `@ObservedObject`
- `ObservableObject` and `@Published`
- `NavigationStack` and `navigationDestination`
- `LazyVGrid` for card grid
- 3D flip animation with `rotation3DEffect`
- `Timer` with Combine
- `UserDefaults` for best score persistence
- `@Environment(\.dismiss)` for navigation
- Reusable view components

## Difficulty Levels

| Level | Pairs | Columns |
|---|---|---|
| 😊 Easy | 6 | 3 |
| 🔥 Medium | 10 | 4 |
| 💀 Hard | 15 | 5 |

## Tech Stack

- Swift 5.9+
- SwiftUI
- Combine
- Xcode 16+
- iOS 17+
