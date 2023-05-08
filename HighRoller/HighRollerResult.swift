//
//  HighRollerResult.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import Foundation

struct HighRollerResult: Codable, Identifiable {
    var id = UUID()
    let results: [DiceResult]
    
    func totalEyes() -> Int {
        return results.compactMap { $0.result }.reduce(0, +)
    }
}

extension HighRollerResult {
    static var example: HighRollerResult {
        return HighRollerResult(results: [
            DiceResult.example,
            DiceResult.example,
            DiceResult.example,
            DiceResult.example,
            DiceResult.example
        ])
    }
}

struct HighRollerResults: Codable, Identifiable {
    var id = UUID()
    var results: [HighRollerResult]
}

extension HighRollerResults {
    static var exampleEmpty: HighRollerResults {
        return HighRollerResults(results: [])
    }
    
    static var example: HighRollerResults {
        return HighRollerResults(results: Array(repeating: HighRollerResult.example, count: 5))
    }
}
