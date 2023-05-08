//
//  ContentView+ViewModel.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var results = HighRollerResults(results: [])
        
        @Published var dice: [Dice] = [.four, .six, .eight, .ten, .twelve, .twenty, .hundred]
        
        @Published var currentResult: HighRollerResult? = nil
        
        @Published var showingResultHistory = false
        
        func diceImageName() -> String {
            guard let currentResult else { return "questionmark.square" }
            
            return "die.face.\(currentResult)"
        }
        
        func rollDice() {
            var rolls: [DiceResult] = []
            
            for d in dice {
                let roll = DiceResult(dice: d, result: d.roll())
                rolls.append(roll)
            }
            
            let highRollerResult = HighRollerResult(results: rolls)
            
            withAnimation {
                currentResult = highRollerResult
            }
            results.results.append(highRollerResult)
        }
        
        func resultViewHeight() -> CGFloat {
            if let currentResult {
                let minRows = currentResult.results.count / 4
                let addExtraRow = currentResult.results.count % 4 > 0
                return Double(minRows + (addExtraRow ? 1 : 0)) * 80
            } else {
                return 0
            }
        }
        
    }
}
