//
//  DiceResult.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import Foundation
import SwiftUI

enum Dice: Int, Codable, CaseIterable {
    case four = 4
    case six = 6
    case eight = 8
    case ten = 10
    case twelve = 12
    case twenty = 20
    case hundred = 100
    
    static var emptyDictionary: [Dice: Int] {
        return [
            .four: 0,
            .six: 0,
            .eight: 0,
            .ten: 0,
            .twelve: 0,
            .twenty: 0,
            .hundred: 0
        ]
    }
    
    func tint(custom: Bool) -> Color {
        guard custom else { return .black }
        
        switch self {
        case .four: return .red
        case .six: return .black
        case .eight: return .blue
        case .ten: return .green
        case .twelve: return .yellow
        case .twenty: return .brown
        case .hundred: return .cyan
        }
    }
    
    func roll() -> Int {
        switch self {
        case .four: return Int.random(in: 1...4)
        case .six: return Int.random(in: 1...6)
        case .eight: return Int.random(in: 1...8)
        case .ten: return Int.random(in: 1...10)
        case .twelve: return Int.random(in: 1...12)
        case .twenty: return Int.random(in: 1...20)
        case .hundred: return Int.random(in: 1...100)
        }
    }
}

struct DiceResult: Codable, Identifiable {
    var id = UUID()
    let dice: Dice
    let result: Int
    let useTint: Bool
    
    @ViewBuilder
    func image(font: Font = .title) -> some View {
        ZStack {
            Image(systemName: diceImageName())
                .resizable()
                .foregroundColor(dice.tint(custom: useTint))
            if result > 6 {
                Text("\(result)")
                    .font(font)
                    .bold()
            }
        }
    }
    
    private func diceImageName() -> String {
        guard result <= 6 else { return "square" }
        
        return "die.face.\(result)"
    }
}

extension DiceResult {
    static var example: DiceResult {
        return DiceResult(dice: .six, result: Dice.six.roll(), useTint: false)
    }
}
