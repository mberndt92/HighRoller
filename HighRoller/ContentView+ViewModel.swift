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
        
        @State private var feedback = UINotificationFeedbackGenerator()
        
        @Published var results = HighRollerResults(results: [])
        
        @Published private(set) var dice: [Dice] = [.four, .six, .eight, .ten, .twelve, .twenty, .hundred]
        @Published var useTint = false
        
        @Published var currentResult: HighRollerResult? = nil
        
        @Published var showingResultHistory = false
        @Published var showingSettings = false
        
        enum SaveFileNames: String {
            case dice = "dice"
            case config = "config"
        }
        
        var diceConfig: [Dice: Int] {
            var allDice: [Dice: Int] = Dice.emptyDictionary
            
            dice.forEach { die in
                allDice[die]! += 1
            }
            
            return allDice
        }
        
        var totalEyes: Int {
            return currentResult?.totalEyes() ?? 0
        }
        
        func diceImageName() -> String {
            guard let currentResult else { return "questionmark.square" }
            
            return "die.face.\(currentResult)"
        }
        
        func rollDice() {
            var rolls: [DiceResult] = []
            
            for d in dice {
                let roll = DiceResult(dice: d, result: d.roll(), useTint: useTint)
                rolls.append(roll)
            }
            
            let highRollerResult = HighRollerResult(results: rolls)
            
            withAnimation {
                currentResult = highRollerResult
            }
            results.results.append(highRollerResult)
            feedback.notificationOccurred(.success)
            save()
        }
        
        func set(_ dice: [Dice]) {
            self.dice = dice
            save()
        }
        
        func set(_ useTint: Bool) {
            self.useTint = useTint
            save()
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
        
        private func save() {
            FileManager.default.saveInDocuments(to: HighRollerResults.saveFileName, data: results)
            FileManager.default.saveInDocuments(to: SaveFileNames.dice.rawValue, data: dice)
            FileManager.default.saveInDocuments(to: SaveFileNames.config.rawValue, data: useTint)
        }
        
        func load() {
            feedback.prepare()
            
            if FileManager.default.fileExists(atPath: FileManager.documentsDirectory.appending(path: HighRollerResults.saveFileName).path()) {
                if let loadedData: HighRollerResults = FileManager.default.loadFromDocuments(HighRollerResults.saveFileName) {
                        results = loadedData
                    }
                }
            
            if FileManager.default.fileExists(atPath: FileManager.documentsDirectory.appending(path: SaveFileNames.dice.rawValue).path()) {
                if let loadedData: [Dice] = FileManager.default.loadFromDocuments(SaveFileNames.dice.rawValue) {
                    dice = loadedData
                }
            }
            
            if FileManager.default.fileExists(atPath: FileManager.documentsDirectory.appending(path: SaveFileNames.config.rawValue).path()) {
                if let loadedData: Bool = FileManager.default.loadFromDocuments(SaveFileNames.config.rawValue) {
                    useTint = loadedData
                }
            }
        }
        
    }
}
