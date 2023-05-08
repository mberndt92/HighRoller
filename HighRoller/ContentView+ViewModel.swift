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
        
        @Published var currentResult: Int? = nil
        
        @Published var showingResultHistory = false
        
        func diceImageName() -> String {
            guard let currentResult else { return "questionmark.square" }
            
            return "die.face.\(currentResult)"
        }
        
        func rollDice() {
            let dice = Dice.six
            let diceResult = DiceResult(dice: dice, result: dice.roll())
            let rollResult = HighRollerResult(results: [diceResult])
            withAnimation {
                currentResult = diceResult.result
            }
            results.results.append(rollResult)
        }
        
    }
}
