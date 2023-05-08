//
//  DiceResult.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import Foundation

enum Dice: String, Codable {
    case four
    case six
    case eight
    case ten
    case twelve
    case twenty
    case hundred
    
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
}

extension DiceResult {
    static var example: DiceResult {
        return DiceResult(dice: .six, result: Dice.six.roll())
    }
}
