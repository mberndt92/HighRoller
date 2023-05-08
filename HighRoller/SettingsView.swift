//
//  SettingsView.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import SwiftUI

struct SettingsView: View {
    
    // Preferring to use incorrect grammar than to use DIE everywhere and not understand the context immediately.
    @State private var dices: [Dice: Int] = [:]
    
    var onSave: ([Dice]) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(Dice.allCases, id: \.rawValue) { dice in
                    HStack(spacing: 15) {
                        DiceResult(dice: dice, result: dice.rawValue).image()
                            .frame(width: 64, height: 64)

                        Stepper("x \(dices[dice]!)") {
                            increment(dice: dice)
                        } onDecrement: {
                            decrement(dice: dice)
                        } onEditingChanged: { change in
                            //
                        }
                        .font(.headline)

                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem {
                    Button("Save", action: save)
                }
            }
        }
    }
    
    init(dices: [Dice : Int], onSave: @escaping ([Dice]) -> Void) {
        self.dices = dices
        self.onSave = onSave
        
        if self.dices[.four] == nil { self.dices[.four] = 0 }
        if self.dices[.six] == nil { self.dices[.six] = 0 }
        if self.dices[.eight] == nil { self.dices[.eight] = 0 }
        if self.dices[.ten] == nil { self.dices[.ten] = 0 }
        if self.dices[.twelve] == nil { self.dices[.twelve] = 0 }
        if self.dices[.twenty] == nil { self.dices[.twenty] = 0 }
        if self.dices[.hundred] == nil { self.dices[.hundred] = 0 }
    }
    
    private func save() {
        var allDice: [Dice] = []
        
        for (dice, value) in dices  {
            for _ in 0..<value {
                allDice.append(Dice(rawValue: dice.rawValue)!)
            }
        }
        
        onSave(allDice)
    }
    
    private func increment(dice: Dice) {
        dices[dice]! += 1
    }
    
    private func decrement(dice: Dice) {
        guard dices[dice]! > 0 else { return }
        
        dices[dice]! -= 1
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(dices: [:], onSave: { _ in })
    }
}
